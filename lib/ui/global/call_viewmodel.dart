import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/enums/call_status.dart';
import 'package:petdoctor/enums/snackbar_variant.dart';
import 'package:petdoctor/services/call_service.dart';
import 'package:petdoctor/ui/diagnosis/data/default.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

abstract class BaseCallViewModel extends BaseViewModel {
  final _log = getLogger('BaseCallViewModel');

  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  final _agoraEngine = locator<RtcEngine>();
  final _callService = locator<CallService>();

  StreamSubscription? subscription;
  Voicecall call = Voicecall.fromMap(kDefaultVoiceCall);

  /// Fields for `Call Module`
  bool isJoined = false;
  bool ended = false;
  bool mute = false;
  bool speaker = false;
  String status = "connecting";

  void toggleMute() async {
    mute = !mute;
    await _agoraEngine.muteLocalAudioStream(mute);
    notifyListeners();
  }

  void toggleSpeaker() async {
    speaker = !speaker;
    await _agoraEngine.setEnableSpeakerphone(speaker);
    notifyListeners();
  }

  _joinChannel(String channelName, String token) async {
    _addListeners();

    await _agoraEngine.leaveChannel();

    await _agoraEngine
        .joinChannel(token, channelName, null, 0)
        .catchError((onError) {
      _log.e('error ${onError.toString()}');
    });
  }

  _addListeners() {
    _agoraEngine.setEventHandler(RtcEngineEventHandler(
      error: (error) {
        _log.e(error);
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        _log.v(
            'joinChannelSuccess $channel $uid $elapsed send farmer notification');
        isJoined = true;
        notifyListeners();
      },
      leaveChannel: (stats) {
        _log.v('leaveChannel ${stats.toJson()}');
        isJoined = false;
        notifyListeners();
      },
    ));
  }

  Future<void> onCallJoin();

  initCall(String channelId) async {
    _log.i("Subscribing to call $channelId");

    setBusy(true);

    subscription =
        _callService.listenToCallUpdates(channelId).listen((event) {});

    subscription?.onData((data) async {
      if (data == null) return;

      setBusy(true);

      call = data;

      await onCallJoin();

      _log.v('${call.status}');

      // accept call from patient
      if (call.status == 'dial') {
        _log.i("Accepting call $channelId");
        var callStatus = CallStatus.Lift;
        await call.reference?.update({"status": callStatus.status});
        _log.v("Call accepted");
      }

      // join call
      else if (call.status == CallStatus.Connect.status) {
        _log.v(
            "Joining call ${call.details.channelId} and token: ${call.details.token}");
        _joinChannel(call.details.channelId, call.details.token!);
      }

      // disconnect call
      else if (call.status == CallStatus.End.status) {
        ended = true;
        _agoraEngine.leaveChannel();
        Fluttertoast.showToast(msg: 'Call Ended');
      }

      //
      else if (call.status == CallStatus.Cancel.status) {
        _navigationService.back();
        return;
      }

      setBusy(false);
    });

    setBusy(false);
  }

  Future<void> disconnect({bool cancel = false}) async {
    if (ended) return;
    setBusy(true);

    if (isJoined) await _agoraEngine.leaveChannel();

    ended = true;

    var callStatus = CallStatus.Connect;
    if (call.status == callStatus.status) {
      var endCallStatus = CallStatus.End;
      await call.reference?.update({'status': endCallStatus.status});
    }

    if (cancel) {
      notifyListeners();
      Fluttertoast.showToast(msg: "The call ended and you can't join call");
    }

    setBusy(false);
  }

  void showCallSheet() async {
    if (ended) return;

    var patientName = call.patient.name;

    var response = await _bottomSheetService.showCustomSheet(
        data: {'mute': mute, 'speaker': speaker},
        variant: SheetType.Call,
        title: patientName);

    if (response?.data is CallSheetResponse) {
      CallSheetResponse data = response?.data;

      switch (data) {
        case CallSheetResponse.End:
          return disconnect();
        case CallSheetResponse.Mute:
          return toggleMute();
        case CallSheetResponse.Speaker:
          return toggleSpeaker();
        default:
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _agoraEngine.leaveChannel();
    subscription?.cancel();
  }
}

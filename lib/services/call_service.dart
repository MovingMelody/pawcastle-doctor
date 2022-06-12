import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/constants/keys.dart';
import 'package:petdoctor/utils/date_formatter.dart';

class CallService {
  final _log = getLogger("CallService");

  final _callsRef = FirebaseFirestore.instance
      .collection(kCallsFirestoreKey)
      .withConverter<Voicecall>(
        fromFirestore: (snapshot, _) => Voicecall.fromSnapshot(snapshot),
        toFirestore: (call, _) => call.toMap(),
      );

  final StreamController<Voicecall> _callStream =
      StreamController<Voicecall>.broadcast();

  final StreamController<Voicecall> _missedCallStream =
      StreamController<Voicecall>.broadcast();

  _getMissedCallStream(String doctorId) {
    _callsRef
        .where('status', isEqualTo: 'dial')
        .where('doctor.id', isEqualTo: doctorId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .listen((result) {
      if (result.docs.isEmpty) return null;
      var doc = result.docs.first;

      if (doc.exists) {
        var expired = DateConverter.getDate(epochString: doc.data().timestamp)
            .isExpired();

        if (!expired) {
          _missedCallStream.add(doc.data().copyWith(reference: doc.reference));
        }
      }
    });
  }

  Stream listenToCallUpdates(String channelId) {
    _getCallStream(channelId);
    return _callStream.stream;
  }

  Stream getMissedCalls(String doctorId) {
    _getMissedCallStream(doctorId);
    return _missedCallStream.stream;
  }

  _getCallStream(String channelId) {
    _callsRef.doc(channelId).snapshots().listen((postsSnapshot) {
      _log.i("Call data updated");
      var data = postsSnapshot.data();
      if (data != null)
        _callStream.add(data.copyWith(reference: postsSnapshot.reference));
    });
  }

  Future<Voicecall?> fetchCall(String channelId) async {
    var doc = await _callsRef.doc(channelId).get();

    if (doc.exists)
      return doc.data();
    else
      return Future.error("No call obj found");
  }
}

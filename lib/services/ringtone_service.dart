import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class RingtoneService {
  bool _isPlaying = false;

  isPlayingK() {}

  play() async {
    if (_isPlaying) await stop();

    await FlutterRingtonePlayer.playRingtone(looping: true)
        .then((value) => _isPlaying = true);
  }

  stop() async =>
      await FlutterRingtonePlayer.stop().then((value) => _isPlaying = false);
}

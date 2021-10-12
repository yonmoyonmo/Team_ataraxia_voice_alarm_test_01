import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class SoundPlayer {
  FlutterSoundPlayer? _voicePlayer;

  Future init() async {
    _voicePlayer = FlutterSoundPlayer();
    await _voicePlayer!.openAudioSession();
  }

  Future dispose() async {
    _voicePlayer!.closeAudioSession();
    _voicePlayer = null;
  }

  again() async {
    print("repeating...");
    await _play();
  }

  Future _play() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String filePath = tempDir.path + "/test.wav";
    print(filePath);
    await _voicePlayer!.startPlayer(
      fromURI: filePath,
      whenFinished: again,
    );
  }

  Future _stop() async {
    await _voicePlayer!.stopPlayer();
  }

  Future togglePlaying() async {
    if (_voicePlayer!.isStopped) {
      await _play();
    } else {
      await _stop();
    }
  }
}

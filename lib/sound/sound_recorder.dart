import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundRecorder {
  FlutterSoundRecorder? _voiceRecorder;
  String? filePath;
  bool _isRecorderInit = false;

  bool get isRecording => _voiceRecorder!.isRecording;

  Future init() async {
    _voiceRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("mic permission is not granted");
    }
    await _voiceRecorder!.openAudioSession();
    _isRecorderInit = true;
  }

  Future dispose() async {
    if (!_isRecorderInit) {
      return;
    }
    _voiceRecorder!.closeAudioSession();
    _voiceRecorder = null;
    _isRecorderInit = false;
  }

  Future _record() async {
    if (!_isRecorderInit) {
      return;
    }
    Directory tempDir = await getApplicationDocumentsDirectory();
    String filePath = tempDir.path + "/test.wav";
    print(filePath);
    await _voiceRecorder!.startRecorder(toFile: filePath);
  }

  Future _stop() async {
    if (!_isRecorderInit) {
      return;
    }
    await _voiceRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (_voiceRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}

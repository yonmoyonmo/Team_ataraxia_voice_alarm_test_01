import 'package:flutter/material.dart';
import 'package:voice_alarm_test_01/screen/set_voice_alarm.dart';
import 'package:voice_alarm_test_01/sound/sound_player.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final SoundPlayer voicePlayer = SoundPlayer();
  @override
  void initState() {
    super.initState();
    voicePlayer.init();
  }

  @override
  void dispose() {
    super.dispose();
    voicePlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    voicePlayer.togglePlaying();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("alarmed"),
            ElevatedButton(
              onPressed: () async {
                await voicePlayer.togglePlaying();
              },
              child: const Text("stop recorded voice"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetVoicAlarm()),
                );
              },
              child: Text("go back"),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:voice_alarm_test_01/sound/sound_player.dart';
import 'package:voice_alarm_test_01/sound/sound_recorder.dart';

class SetVoicAlarm extends StatefulWidget {
  const SetVoicAlarm({Key? key}) : super(key: key);

  @override
  _SetVoicAlarmState createState() => _SetVoicAlarmState();
}

class _SetVoicAlarmState extends State<SetVoicAlarm> {
  static void emptyCallback() {}
  DateTime dateTime = DateTime.now();
  int durationSeconds = 0;
  String? message;
  int countingId = 0;

  final SoundRecorder voiceRecorder = SoundRecorder();
  final SoundPlayer voicePlayer = SoundPlayer();

  @override
  void initState() {
    super.initState();
    voiceRecorder.init();
    voicePlayer.init();
  }

  @override
  void dispose() {
    super.dispose();
    voiceRecorder.dispose();
    voicePlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("voice alarm demo"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Voice Alarm Test 01",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(durationSeconds.toString()),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  decoration:
                      const InputDecoration(label: Text("how much seconds")),
                  onChanged: (text) {
                    setState(() {
                      durationSeconds = int.parse(text);
                    });
                  },
                  onSubmitted: (text) {
                    setState(() {
                      durationSeconds = int.parse(text);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              //------------
              ElevatedButton(
                onPressed: () async {
                  await voiceRecorder.toggleRecording();
                },
                child: const Text("start record"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await voiceRecorder.toggleRecording();
                },
                child: const Text("stop record"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await voicePlayer.togglePlaying();
                },
                child: const Text("play recorded voice"),
              ),
              ElevatedButton(
                onPressed: () async {
                  await voicePlayer.togglePlaying();
                },
                child: const Text("stop recorded voice"),
              ),
              //--------------

              if (message != null)
                Text(
                  message!,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),

              ElevatedButton(
                  onPressed: () {
                    if (durationSeconds != 0) {
                      setState(() {
                        dateTime = DateTime.now()
                            .add(Duration(seconds: durationSeconds));
                      });

                      print("duration is set");

                      AndroidAlarmManager.oneShotAt(
                        dateTime,
                        countingId,
                        emptyCallback,
                        alarmClock: true,
                        wakeup: true,
                        rescheduleOnReboot: true,
                      );
                      setState(() {
                        countingId++;
                      });
                    } else {
                      setState(() {
                        message = "no input";
                      });
                    }
                  },
                  child: const Text("set the alarm"))
            ],
          ),
        ),
      ),
    );
  }
}

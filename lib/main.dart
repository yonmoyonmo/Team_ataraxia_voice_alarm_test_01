import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:voice_alarm_test_01/alarm_polling_worker.dart';
import 'package:voice_alarm_test_01/alarm_screen.dart';
import 'package:voice_alarm_test_01/store/alarm_status.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AndroidAlarmManager.initialize();
  AlarmPollingWorker().createPollingWorker();

  runApp(const VoiceAlarm());
}

class VoiceAlarm extends StatelessWidget {
  const VoiceAlarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'voice_alarm_demo_01',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VoiceAlarmHome(),
    );
  }
}

//------------------------------------------------

class VoiceAlarmHome extends StatefulWidget {
  const VoiceAlarmHome({Key? key}) : super(key: key);
  @override
  State<VoiceAlarmHome> createState() => VoiceAlarmHomeState();
}

class VoiceAlarmHomeState extends State<VoiceAlarmHome>
    with WidgetsBindingObserver {
  static void emptyCallback() {}

  DateTime dateTime = DateTime.now();
  int durationSeconds = 0;
  String? message;
  int countingId = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        AlarmPollingWorker().createPollingWorker();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        AlarmStatus status = AlarmStatus();
        if (status.isFired) {
          return const AlarmScreen();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("voice alarm demo"),
            ),
            body: Center(
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
                  TextField(
                    decoration:
                        const InputDecoration(label: Text("how much seconds")),
                    onChanged: (text) {
                      setState(() {
                        durationSeconds = int.parse(text);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
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
          );
        }
      },
    );
  }
}

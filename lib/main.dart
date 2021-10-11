import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
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

class VoiceAlarmHome extends StatefulWidget {
  const VoiceAlarmHome({Key? key}) : super(key: key);
  @override
  State<VoiceAlarmHome> createState() => VoiceAlarmHomeState();
}

class VoiceAlarmHomeState extends State<VoiceAlarmHome> {
  static void showprint() {
    print('alarm done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("voice alarm demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("asdasdas"),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () {
                  AndroidAlarmManager.oneShot(
                    const Duration(seconds: 5),
                    1,
                    showprint,
                    alarmClock: true,
                    wakeup: true,
                    rescheduleOnReboot: true,
                  );
                },
                child: const Text("tttest"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

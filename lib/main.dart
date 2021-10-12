import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice_alarm_test_01/alarm/alarm_polling_worker.dart';
import 'package:voice_alarm_test_01/screen/alarm_screen.dart';
import 'package:voice_alarm_test_01/screen/set_voice_alarm.dart';
import 'package:voice_alarm_test_01/store/alarm_status.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var status = await Permission.ignoreBatteryOptimizations.request();
  print("ignoreBatteryOptimizations permission acquired");
  if (status.isDenied) {
    return;
  } else {
    var status2 = await Permission.systemAlertWindow.request();
    print("systemAlertWindow permission acquired");
    if (status2.isDenied) {
      return;
    } else {
      var status3 = await Permission.storage.request();
      if (status3.isDenied) {
        return;
      } else {
        await AndroidAlarmManager.initialize();
        AlarmPollingWorker().createPollingWorker();
        runApp(const VoiceAlarm());
      }
    }
  }
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
        AlarmPollingWorker().createPollingWorker();
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
          return const SetVoicAlarm();
        }
      },
    );
  }
}

/**
 * 알람마다 유니크한 아이디를 줘야하는데...
 * 알람 리스트를 JSON 파일로 유지해야 하는데...
 * 알람마다 목소리가 달라야 하는데...
 * 하나의 알람 하나의 목소리 정책이라면....?
 * 일단 IOS는 버린다...?
 */
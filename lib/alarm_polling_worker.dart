import 'package:voice_alarm_test_01/alarm_flag_manager.dart';
import 'package:voice_alarm_test_01/store/alarm_status.dart';

class AlarmPollingWorker {
  static final AlarmPollingWorker _instance = AlarmPollingWorker._();
  factory AlarmPollingWorker() => _instance;
  AlarmPollingWorker._();

  bool _running = false;

  // 알람 플래그 탐색을 시작한다.
  void createPollingWorker() async {
    if (_running) return;

    _running = true;
    _poller(10).then((callbackAlarmId) async {
      _running = false;
      if (callbackAlarmId != null) {
        final alarmStatus = AlarmStatus();

        if (alarmStatus.callbackAlarmId == null) {
          alarmStatus.fire(callbackAlarmId);
        }
        await AlarmFlagManager().clear();
      }
    });
  }

  // 알람 플래그를 찾은 경우 해당 알람의 Id를 반환하고, 플래그가 없는 경우 null을 반환한다.
  Future<int?> _poller(int iterations) async {
    int? alarmId;
    int iterator = 0;

    await Future.doWhile(() async {
      alarmId = await AlarmFlagManager().getFiredId();
      if (alarmId != null || iterator++ >= iterations) return false;
      await Future.delayed(const Duration(milliseconds: 25));
      return true;
    });
    return alarmId;
  }
}

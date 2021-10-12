import 'package:mobx/mobx.dart';

part 'alarm_status.g.dart';

class AlarmStatus extends _AlarmStatus with _$AlarmStatus {
  static final AlarmStatus _instance = AlarmStatus._();

  factory AlarmStatus() {
    return _instance;
  }

  AlarmStatus._();
}

abstract class _AlarmStatus with Store {
  @observable
  bool _isFired = false;

  @computed
  bool get isFired => _isFired;

  int? callbackAlarmId;

  @action
  void fire(int id) {
    callbackAlarmId = id;
    _isFired = true;
  }

  @action
  void clear() {
    _isFired = false;
    callbackAlarmId = null;
  }
}

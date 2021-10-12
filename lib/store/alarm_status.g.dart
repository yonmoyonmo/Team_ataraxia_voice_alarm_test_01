// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlarmStatus on _AlarmStatus, Store {
  Computed<bool>? _$isFiredComputed;

  @override
  bool get isFired => (_$isFiredComputed ??=
          Computed<bool>(() => super.isFired, name: '_AlarmStatus.isFired'))
      .value;

  final _$_isFiredAtom = Atom(name: '_AlarmStatus._isFired');

  @override
  bool get _isFired {
    _$_isFiredAtom.reportRead();
    return super._isFired;
  }

  @override
  set _isFired(bool value) {
    _$_isFiredAtom.reportWrite(value, super._isFired, () {
      super._isFired = value;
    });
  }

  final _$_AlarmStatusActionController = ActionController(name: '_AlarmStatus');

  @override
  void fire(int id) {
    final _$actionInfo =
        _$_AlarmStatusActionController.startAction(name: '_AlarmStatus.fire');
    try {
      return super.fire(id);
    } finally {
      _$_AlarmStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo =
        _$_AlarmStatusActionController.startAction(name: '_AlarmStatus.clear');
    try {
      return super.clear();
    } finally {
      _$_AlarmStatusActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isFired: ${isFired}
    ''';
  }
}

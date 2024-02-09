import 'package:flutter/material.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  int _userId = 0;
  int get userId => _userId;
  set userId(int value) {
    _userId = value;
  }

  String _token = '';
  String get token => _token;
  set token(String value) {
    _token = value;
  }

  String _refreshToken = '';
  String get refreshToken => _refreshToken;
  set refreshToken(String value) {
    _refreshToken = value;
  }

  bool _success = false;
  bool get success => _success;
  set success(bool value) {
    _success = value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

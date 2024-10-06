import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  String _currentTime = '';

  TimerProvider() {
    _startTimer();
  }

  String get currentTime => _currentTime;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _currentTime = DateFormat('hh:mm a').format(DateTime.now());
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
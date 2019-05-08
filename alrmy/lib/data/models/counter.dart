import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:duration/duration.dart';

class CounterModel extends Model {
  Duration _currentTime = Duration();
  int _duration = 1;
  bool _isPaused = false;
  Timer _timer;

  /// Wether the timer is started
  bool get inProgress => _timer?.isActive ?? false;

  /// Duration in Minutes for the Timer
  int get duration => _duration;

  double get progress {
    return (currentTime).inSeconds / Duration(minutes: duration).inSeconds;
  }

  bool get isPaused => _isPaused;

  Duration get currentTime => _currentTime;
  String get result {
    return printDuration(_currentTime);
  }

  void _updateTime() {
    if (!_isPaused) {
      _currentTime = _currentTime - Duration(milliseconds: 1);
      notifyListeners();
    }
  }

  void start() {
    _isPaused = false;
    _currentTime = Duration(minutes: _duration);
    _timer = Timer.periodic(Duration(milliseconds: 1), (Timer value) {
      if (_currentTime.inSeconds == 0) {
        stop();
      } else {
        _updateTime();
      }
    });
    notifyListeners();
  }

  void stop() {
    _timer.cancel();
    _timer = null;
    notifyListeners();
  }

  void pause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  void changeDuration(int value) {
    _duration = value;
    notifyListeners();
  }
}

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  CountdownCubit() : super(CountdownIdeal());

  Timer? _countdownTimer;

  Duration _duration = const Duration();

  Duration get duration => _duration;

  startTimer() {
    stopTimer();
    emit(CountdownIdeal());
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final seconds = _duration.inSeconds - 1;
      _duration = Duration(seconds: seconds);
      if (seconds <= 0) {
        timer.cancel();
        emit(CountdownFinish());
      } else {
        emit(CountdownOnTick());
      }
    });
  }

  stopTimer() {
    if (_countdownTimer != null) {
      _countdownTimer?.cancel();
    }
    _duration = const Duration(minutes: 56);
  }
}

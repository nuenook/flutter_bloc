import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer/ticker.dart';
import 'package:flutter_timer/time_event.dart';
import 'package:flutter_timer/time_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  final Ticker _ticker;
  final int _duration = 60;

  StreamSubscription<int> _tickerSubscription;

  TimeBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  TimeState get initialState => Ready(_duration);

  @override
  Stream<TimeState> mapEventToState(TimeEvent event) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is Resume) {
      yield* _mapResumeToState(event);
    } else if (event is Pause) {
      yield* _mapPauseToState(event);
    } else if (event is Tick) {
      yield* _mapTickToState(event);
    } else if (event is Reset) {
      yield* _mapResetToState(event);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Stream<TimeState> _mapStartToState(Start start) async* {
    yield Running(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(Tick(duration: duration)));
  }

  Stream<TimeState> _mapTickToState(Tick tick) async* {
    yield tick.duration > 0 ? Running(tick.duration) : Finished(0);
  }

  Stream<TimeState> _mapPauseToState(Pause pause) async* {
    if (state is Running) {
      _tickerSubscription?.pause();
      yield Paused(state.duration);
    }
  }

  Stream<TimeState> _mapResumeToState(Resume pause) async* {
    if (state is Paused) {
      _tickerSubscription?.resume();
      yield Running(state.duration);
    }
  }

  Stream<TimeState> _mapResetToState(Reset reset) async* {
    _tickerSubscription?.cancel();
    yield Ready(_duration);
  }
}

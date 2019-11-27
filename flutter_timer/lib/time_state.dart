import 'package:equatable/equatable.dart';

abstract class TimeState extends Equatable {
  final int duration;

  const TimeState(this.duration);

  @override
  List<Object> get props => [duration];
}

class Ready extends TimeState {
  Ready(int duration) : super(duration);

  @override
  String toString() => 'Ready { duration: $duration}';
}

class Paused extends TimeState {
  Paused(int duration) : super(duration);

  @override
  String toString() => 'Paused {duration: $duration }';
}

class Running extends TimeState {
  Running(int duration) : super(duration);

  @override
  String toString() => 'Running {duration: $duration}';
}

class Finished extends TimeState {
  Finished(int duration) : super(0);
}
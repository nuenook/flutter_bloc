import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

class Start extends TimeEvent {
  final int duration;

  Start({@required this.duration});

  @override
  String toString() => "Start {duration: $duration}";
}

class Pause extends TimeEvent {}

class Resume extends TimeEvent {}

class Reset extends TimeEvent {}

class Tick extends TimeEvent {
  final int duration;

  Tick({@required this.duration});

  @override 
  List<Object> get props => [duration];

  @override 
  String toString() => 'Tick {duration: $duration}';
}

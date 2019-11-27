import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/time_bloc.dart';
import 'package:flutter_timer/time_state.dart';

import 'time_event.dart';

class ActionsTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
        timerBloc: BlocProvider.of<TimeBloc>(context),
      ),
    );
  }

  List<Widget> _mapStateToActionButtons({
    TimeBloc timerBloc,
  }) {
    final TimeState currentState = timerBloc.state;
    if (currentState is Ready) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () =>
              timerBloc.add(Start(duration: currentState.duration)),
        )
      ];
    }

    if (currentState is Running) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBloc.add(Pause()),
        ),
        FloatingActionButton(
            child: Icon(Icons.replay), onPressed: () => timerBloc.add(Reset()))
      ];
    }

    if (currentState is Paused) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(Resume()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(Reset()),
        ),
      ];
    }
    if (currentState is Finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(Reset()),
        ),
      ];
    }
    return [];
  }
}

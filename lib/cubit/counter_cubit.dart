import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitialState());

  void increment() {
    final int newCounterState = state.counter + 1;
    final String newStatus = newCounterState % 2 == 0 ? "Genap" : "Ganjil";
    final Color newColor = newCounterState % 2 == 0 ? Colors.blue : Colors.purple;
    emit(CounterState(counter: newCounterState, status: newStatus, color: newColor));
  }

  void decrement() {
    final int newCounterState = state.counter - 1;
    final String newStatus = newCounterState % 2 == 0 ? "Genap" : "Ganjil";
    final Color newColor = newCounterState % 2 == 0 ? Colors.blue : Colors.purple;
    emit(CounterState(counter: newCounterState, status: newStatus, color: newColor));
  }
}

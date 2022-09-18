import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'two_numbers_event.dart';
part 'two_numbers_state.dart';

class TwoNumbersBloc extends Bloc<TwoNumbersEvent, TwoNumbersState> {
  TwoNumbersBloc() : super(const TwoNumbersInitial()) {
    on<CustomTwoNumbersEvent>(_onCustomTwoNumbersEvent);
    on<FirstNumberUpdated>(_onFirstNumberUpdated);
    on<SecondNumberUpdated>(_onSecondNumberUpdated);
    on<NextOperationSelected>(_onNextOperationSelected);
    on<PreviousOperationSelected>(_onPreviousOperationSelected);
  }

  FutureOr<void> _onCustomTwoNumbersEvent(
    CustomTwoNumbersEvent event,
    Emitter<TwoNumbersState> emit,
  ) {
    // TODO: Add Logic
  }

  FutureOr<void> _onFirstNumberUpdated(
    FirstNumberUpdated event,
    Emitter<TwoNumbersState> emit,
  ) {
    if (event.firstNumber != state.firstNumber) {
      emit(state.copyWith(firstNumber: event.firstNumber));
    }
    switch (state.operation) {
      case Operation.add:
        emit(state.copyWith(result: event.firstNumber + state.secondNumber));
        break;
      case Operation.subtract:
        emit(state.copyWith(result: event.firstNumber - state.secondNumber));
        break;
      case Operation.multiply:
        emit(state.copyWith(result: event.firstNumber * state.secondNumber));
        break;
      case Operation.divide:
        emit(state.copyWith(result: event.firstNumber / state.secondNumber));
        break;
      case Operation.none:
        emit(state.copyWith(result: 0));
        break;
    }
  }

  FutureOr<void> _onSecondNumberUpdated(
    SecondNumberUpdated event,
    Emitter<TwoNumbersState> emit,
  ) {
    if (event.secondNumber != state.secondNumber) {
      emit(state.copyWith(secondNumber: event.secondNumber));
    }
    switch (state.operation) {
      case Operation.add:
        emit(
          state.copyWith(
            result: state.firstNumber + event.secondNumber,
          ),
        );
        break;
      case Operation.subtract:
        emit(
          state.copyWith(
            result: state.firstNumber - event.secondNumber,
          ),
        );
        break;
      case Operation.multiply:
        emit(
          state.copyWith(
            result: state.firstNumber * event.secondNumber,
          ),
        );
        break;
      case Operation.divide:
        emit(
          state.copyWith(
            result: state.firstNumber / event.secondNumber,
          ),
        );
        break;
      case Operation.none:
        emit(state.copyWith(result: 0));
        break;
    }
  }

  FutureOr<void> _onNextOperationSelected(
    NextOperationSelected event,
    Emitter<TwoNumbersState> emit,
  ) {
    switch (state.operation) {
      case Operation.none:
        emit(
          state.copyWith(
            operation: Operation.add,
            result: state.firstNumber + state.secondNumber,
          ),
        );
        break;
      case Operation.add:
        emit(
          state.copyWith(
            operation: Operation.subtract,
            result: state.firstNumber - state.secondNumber,
          ),
        );
        break;
      case Operation.subtract:
        emit(
          state.copyWith(
            operation: Operation.multiply,
            result: state.firstNumber * state.secondNumber,
          ),
        );
        break;
      case Operation.multiply:
        emit(
          state.copyWith(
            operation: Operation.divide,
            result: state.firstNumber / state.secondNumber,
          ),
        );
        break;
      case Operation.divide:
        emit(
          state.copyWith(
            operation: Operation.none,
            result: 0,
          ),
        );
        break;
    }
  }

  FutureOr<void> _onPreviousOperationSelected(
    PreviousOperationSelected event,
    Emitter<TwoNumbersState> emit,
  ) {
    switch (state.operation) {
      case Operation.none:
        emit(state.copyWith(
          operation: Operation.divide,
          result: state.firstNumber / state.secondNumber,
        ));
        break;
      case Operation.add:
        emit(state.copyWith(
          operation: Operation.none,
          result: 0,
        ));
        break;
      case Operation.subtract:
        emit(state.copyWith(
          operation: Operation.add,
          result: state.firstNumber + state.secondNumber,
        ));
        break;
      case Operation.multiply:
        emit(state.copyWith(
          operation: Operation.subtract,
          result: state.firstNumber - state.secondNumber,
        ));
        break;
      case Operation.divide:
        emit(state.copyWith(
          operation: Operation.multiply,
          result: state.firstNumber * state.secondNumber,
        ));
        break;
    }
  }
}
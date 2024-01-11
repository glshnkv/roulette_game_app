import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roulette_game_app/services/shared_preferences.dart';

part 'tries_event.dart';
part 'tries_state.dart';

class TriesBloc extends Bloc<TriesEvent, TriesState> {
  TriesBloc() : super(TriesInitial()) {
    on<GetTriesEvent>(_getTriesHandler);
    on<DecrementTriesEvent>(_decrementTriesHandler);
    on<ImplementTriesEvent>(_implementTriesHandler);
    on<CheckCountTriesEvent>(_checkTriesHandler);

  }
  void _getTriesHandler(
      GetTriesEvent event, Emitter<TriesState> emit) async {
    SharedPreferencesService storage = await SharedPreferencesService.getInstance();
    emit(LoadingTriesState());
    emit(UpdateTriesState(tries: storage.tries));
  }

  void _checkTriesHandler(
      CheckCountTriesEvent event, Emitter<TriesState> emit) async {
    SharedPreferencesService storage = await SharedPreferencesService.getInstance();
    if (storage.tries > 0) {
      emit(EnoughTriesState());
    } else {
      emit(NotEnoughTriesState());
    }
  }

  void _decrementTriesHandler(
      DecrementTriesEvent event, Emitter<TriesState> emit) async {
    SharedPreferencesService storage = await SharedPreferencesService.getInstance();
    storage.tries -= 1;
    emit(UpdateTriesState(tries: storage.tries));
  }

  void _implementTriesHandler(
      ImplementTriesEvent event, Emitter<TriesState> emit) async {
    SharedPreferencesService storage = await SharedPreferencesService.getInstance();
    storage.tries += 5;
    emit(UpdateTriesState(tries: storage.tries));
  }
}

part of 'tries_bloc.dart';

@immutable
abstract class TriesState {}

class TriesInitial extends TriesState {}

class LoadingTriesState extends TriesState {}

class UpdateTriesState extends TriesState {
  final int tries;

  UpdateTriesState({required this.tries});
}

class EnoughTriesState extends TriesState {}

class NotEnoughTriesState extends TriesState {}



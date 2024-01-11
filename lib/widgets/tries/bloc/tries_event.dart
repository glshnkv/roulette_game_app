part of 'tries_bloc.dart';

@immutable
abstract class TriesEvent {}

class GetTriesEvent extends TriesEvent {}

class CheckCountTriesEvent extends TriesEvent {}

class DecrementTriesEvent extends TriesEvent {}

class ImplementTriesEvent extends TriesEvent {}



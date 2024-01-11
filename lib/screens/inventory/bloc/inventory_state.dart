part of 'inventory_bloc.dart';

@immutable
abstract class InventoryState {}

class InventoryInitial extends InventoryState {}

class UpdateInventoryState extends InventoryState {
  final List<String> inventory;

  UpdateInventoryState({required this.inventory});
}

class EmptyInventoryState extends InventoryState {}

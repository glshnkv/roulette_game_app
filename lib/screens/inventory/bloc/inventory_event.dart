part of 'inventory_bloc.dart';

@immutable
abstract class InventoryEvent {}

class GetInventoryEvent extends InventoryEvent {}

class AddItemEvent extends InventoryEvent {
  final String item;

  AddItemEvent({required this.item});
}


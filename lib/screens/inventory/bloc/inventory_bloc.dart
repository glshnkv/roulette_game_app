import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roulette_game_app/repository/inventory_repository.dart';
import 'package:roulette_game_app/services/shared_preferences.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepository _inventoryRepository;
  InventoryBloc(this._inventoryRepository) : super(InventoryInitial()) {
    on<GetInventoryEvent>(_getInventoryHandler);
    on<AddItemEvent>(_addItemHandler);

  }

  void _getInventoryHandler(
      GetInventoryEvent event, Emitter<InventoryState> emit) async {
    // SharedPreferencesService storage = await SharedPreferencesService.getInstance();
    if (_inventoryRepository.getInventory.isEmpty) {
      emit(EmptyInventoryState());
    } else {
      emit(UpdateInventoryState(inventory: _inventoryRepository.getInventory));
    }
  }

  void _addItemHandler(
      AddItemEvent event, Emitter<InventoryState> emit) async {
    // SharedPreferencesService storage = await SharedPreferencesService.getInstance();
    if (_inventoryRepository.getInventory.length == 15) {
      _inventoryRepository.getInventory.removeAt(0);
    }
    _inventoryRepository.addItem(event.item);
    emit(UpdateInventoryState(inventory: _inventoryRepository.getInventory));
  }
}

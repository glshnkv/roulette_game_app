class InventoryRepository {
  List<String> _inventory = [];

  List<String> get getInventory => _inventory;

  void addItem(String item) => _inventory.add(item);

}
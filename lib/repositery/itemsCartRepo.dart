import 'package:book_store/models/cartItem.dart';
import 'package:flutter/material.dart';

class ItemCartRepo with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();

    // Other methods...
  }
}

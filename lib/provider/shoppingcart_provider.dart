//The shoppingcart_provider.dart contains the changenotifier.
// This contains all the functions thatare to be done in the shopping cart,
// such as adding items, removing items, or removing all items.
import 'package:flutter/material.dart';
import '../model/Item.dart';

class ShoppingCart with ChangeNotifier {

  final List<Item> _shoppingList = [];
  double cartTotal = 0;
  List<Item> get cart => _shoppingList;
  void addItem(Item item) {
    _shoppingList.add(item);
    cartTotal = cartTotal + item.price;
     notifyListeners();
  }
  void removeAll() {
    _shoppingList.clear();
    cartTotal = 0; 
    notifyListeners();
  }
  void removeItem(String name) {
    for (int i = 0; i < _shoppingList.length; i++) {
    if (_shoppingList[i].name == name) {
        cartTotal = cartTotal - _shoppingList[i].price;
        _shoppingList.remove(_shoppingList[i]);
        break;
      }
    } notifyListeners();
  }

  int checker(){
    if (_shoppingList.isEmpty){
      return 1;
    }
    return 0;
  }

}
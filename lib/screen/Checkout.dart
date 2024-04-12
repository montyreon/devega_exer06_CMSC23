import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

//this the widget has a list of the consumers selected items 
//together with their prospective prices and the total amount in the shopping cart
class Checkout extends StatelessWidget{
  const Checkout({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:  AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          selectedItems(context),
          computeCost(),
          const Divider(height: 4, color: Colors.black),
          ElevatedButton(
            onPressed: (){
              if(context.read<ShoppingCart>().checker() == 1){
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Cart is Empty!!"),
                  duration: Duration(
                    seconds: 1,
                    milliseconds: 100
                  ), 
                ));
              }else{
              resetTotalCost();
              context.read<ShoppingCart>().removeAll();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Payment Successful!"),
                  duration: Duration(
                    seconds: 1,
                    milliseconds: 100
                  ), 
                ));
                Navigator.pushNamed(context, "/products");

              }
            },
            child: const Text("Pay Now!")
          )
        ],
      )
    );
  }

  Widget selectedItems(BuildContext context) { 
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty
      ? const Text('No Items yet!')
      : Expanded(
            child: Column(
              children: [
              Flexible(
                child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(Icons.food_bank_rounded),
                  title: Text(products[index].name),
                  trailing: Text("${products[index].price}")
                );
              },
            )
          ),
        ],
      )
    );
  }
}

Widget computeCost(){
  return Consumer<ShoppingCart>(
    builder: (context, cart, child){
      return Text("Total: ${cart.cartTotal}");
    }
  );
}

Widget resetTotalCost(){
  return Consumer<ShoppingCart>(
    builder: (context, cart, child){
     context.read<ShoppingCart>().removeAll();
      return Text("Total: ${cart.cartTotal}");
    }
  );
}
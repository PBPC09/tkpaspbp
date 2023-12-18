import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/buybooks/models/cart_item.dart';
import 'package:lembarpena/authentication/login_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> futureCartItems;
  Map<int, bool> itemsChecked = {};

  @override
  void initState() {
    super.initState();
    futureCartItems = fetchCartItems();
  }

  Future<List<CartItem>> fetchCartItems() async {
    String uname = LoginPage.uname;
    var url =
        Uri.parse('http://127.0.0.1:8000/buybooks/show_cart_json/$uname/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var cartJson = json.decode(response.body) as List;
      return cartJson.map((json) => CartItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cart');
    }
  }

  void removeItemFromCart(int itemId) {
    setState(() {
      futureCartItems = fetchCartItems();
    });
  }

  void toggleCheckbox(int itemId, bool? value) {
    setState(() {
      itemsChecked[itemId] = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<CartItem>>(
        future: futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            for (var item in snapshot.data!) {
              itemsChecked.putIfAbsent(item.id, () => false);
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var cartItem = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.title,
                                style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text("Jumlah: ${cartItem.quantity}",
                                style: const TextStyle(fontSize: 12.0)),
                            const SizedBox(height: 10),
                            Text(
                                "Subtotal Harga: ${cartItem.currency} ${cartItem.subtotal}",
                                style: const TextStyle(
                                    fontSize: 12.0, color: Colors.grey)),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Checkbox(
                            value: itemsChecked[cartItem.id],
                            onChanged: (bool? value) {
                              toggleCheckbox(cartItem.id, value);
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 1,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(
                                  8), // Atur padding di sini sesuai dengan keinginan
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              removeItemFromCart(cartItem.id);
                            },
                            child: const Text(
                              'Remove',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Your cart is empty.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Implementasi checkout modul Rifqi
        },
        label: const Text('Checkout'),
        icon: const Icon(Icons.payment),
        backgroundColor: Colors.indigo[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

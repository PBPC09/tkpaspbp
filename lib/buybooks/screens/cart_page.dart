import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'package:lembarpena/buybooks/models/cart_item.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> futureCartItems;
  final Map<int, bool> itemsChecked = {};

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
      List<CartItem> cartItems =
          cartJson.map((json) => CartItem.fromJson(json)).toList();
      for (var item in cartItems) {
        itemsChecked.putIfAbsent(item.id, () => false);
      }
      return cartItems;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  void removeItemFromCart(int itemId) {
    // Implementasi fungsi untuk menghapus item dari keranjang
    setState(() {
      futureCartItems = fetchCartItems();
    });
  }

  void toggleCheckbox(int itemId, bool? value) {
    if (value != null) {
      setState(() {
        itemsChecked[itemId] = value;
      });
    }
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var cartItem = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      children: [
                        ListTile(
                          leading: Checkbox(
                            value: itemsChecked[cartItem.id] ?? false,
                            onChanged: (bool? value) {
                              toggleCheckbox(cartItem.id, value);
                            },
                          ),
                          title: Text(
                            cartItem.title,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Jumlah: ${cartItem.quantity}\nSubtotal Harga: ${cartItem.currency} ${cartItem.subtotal}",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black87,
                            ),
                          ),
                          isThreeLine: true, // Jika subtitle memiliki dua baris
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.redAccent,
                              disabledForegroundColor:
                                  Colors.grey.withOpacity(0.38),
                            ),
                            onPressed: () {
                              removeItemFromCart(cartItem.id);
                            },
                            child: const Text('Remove'),
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
          // Implementasi checkout modul si Rifqi
        },
        label: const Text('Checkout'),
        icon: const Icon(Icons.payment),
        backgroundColor: Colors.indigo[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        backgroundColor: Colors.indigo,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 156, 143, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ganti dengan path gambar yang sesuai
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Ganti dengan path gambar yang sesuai
            label: 'Explore Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum), // Ganti dengan path gambar yang sesuai
            label: 'Book Forum',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MyHomePage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ExploreBooksPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ForumPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

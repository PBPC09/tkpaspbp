import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'package:lembarpena/buybooks/models/cart_item.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';
import 'package:lembarpena/checkoutbook/screens/checkoutpage.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> futureCartItems;
  final Map<int, bool> itemsChecked = {};

  Future<List<CartItem>> getCartItems() {
    return fetchCartItems();
  }

  @override
  void initState() {
    super.initState();
    futureCartItems = fetchCartItems();
  }

  Future<List<CartItem>> fetchCartItems() async {
    String uname = LoginPage.uname;
    var url = Uri.parse(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/buybooks/show_cart_json/$uname/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var cartJson = json.decode(response.body) as List;
      List<CartItem> cartItems =
          cartJson.map((json) => CartItem.fromJson(json)).toList();
      Map<int, bool> tempItemsChecked = {};
      for (var item in cartItems) {
        tempItemsChecked[item.id] = item.isSelected;
      }
      // Update the state once after loading all data
      setState(() {
        itemsChecked.addAll(tempItemsChecked);
      });
      return cartItems;
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<void> removeItemFromCart(CookieRequest request, int itemId) async {
    // Implementasi fungsi untuk menghapus item dari keranjang
    final response = await request.postJson(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/buybooks/delete_cart_flutter/$itemId/',
        jsonEncode({}));

    if (response['status'] == 'success') {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sukses dihapus!")));
      // Handle berhasil menghapus
      setState(() {
        // Memuat ulang data ForumHead
        // futureCartItems = fetchCartItems();
        itemsChecked.remove(itemId); // Hapus item dari itemsChecked

        futureCartItems = fetchCartItems();
      });
      // Muat ulang komentar
    } else {
      // Handle error
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Gagal menghapus item.")));
    }
  }

  void toggleCheckbox(CookieRequest request, int itemId, bool? value) async {
    setState(() {
      itemsChecked[itemId] = value ?? false;
    });
    final response = await request.postJson(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/buybooks/selected_flutter/$itemId/',
        jsonEncode({}));

    if (response['status'] == 'success') {
      // Handle berhasil menghapus
      setState(() {});

      // Muat ulang komentar
    } else {
      // Handle error
    }
  }

  bool isAnyItemSelected() {
    return itemsChecked.containsValue(true);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Center(
                    child: Text(
                        'Anda belum memasukkan apapun ke dalam keranjang!',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var cartItem = snapshot.data![index];
                  cartItem.isSelected = itemsChecked[cartItem.id] ?? false;
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: Checkbox(
                              // value: true,
                              value: cartItem.isSelected,
                              onChanged: (bool? value) {
                                toggleCheckbox(request, cartItem.id, value);
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
                            isThreeLine:
                                true, // Jika subtitle memiliki dua baris
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: IconButton(
                              onPressed: () {
                                removeItemFromCart(request, cartItem.id);
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: Text('Your cart is empty.'));
          }
        },
      ),
      floatingActionButton: isAnyItemSelected()
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const CheckoutPage(), // Ganti dengan nama halaman CheckoutPage yang sesuai
                  ),
                );
                // Implementasi checkout modul si Rifqi
              },
              label:
                  const Text('Checkout', style: TextStyle(color: Colors.white)),
              icon: const Icon(Icons.payment, color: Colors.white),
              backgroundColor: Colors.indigo[900],
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // currentIndex: 9,
        backgroundColor: Colors.indigo,
        selectedItemColor: const Color.fromARGB(255, 156, 143, 255),
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

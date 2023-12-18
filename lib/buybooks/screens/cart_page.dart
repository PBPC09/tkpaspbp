import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lembarpena/buybooks/models/cart_item.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartItem>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _cartItemsFuture = fetchProduct();
  }

  Future<List<CartItem>> fetchProduct() async {
    String uname = LoginPage.uname;
    var url = Uri.parse('http://127.0.0.1:8000/show_cart_json/$uname/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<CartItem> cartItems = cartItemFromJson(jsonEncode(data));
    return cartItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<CartItem>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada barang di keranjang.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CartItem cartItem = snapshot.data![index];
                return ListTile(
                  title: Text(cartItem.fields.book.toString()),
                  subtitle: Text('Jumlah: ${cartItem.fields.quantity.toString()}'),
                  // Add other widgets as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}

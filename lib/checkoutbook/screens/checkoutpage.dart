import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/buybooks/models/cart_item.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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

    List<CartItem> listItem = [];
    for (var d in data) {
      if (d != null) {
        listItem.add(CartItem.fromJson(d));
      }
    }
    return listItem;
  }

  String _groupValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<CartItem>>(
              future: _cartItemsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Tidak ada barang di keranjang.'));
                } else {
                  return Column(
                    children: snapshot.data!.map((item) {
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text('Quantity: ${item.quantity.toString()}'),
                        // Add other widgets as needed
                      );
                    }).toList(),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            const ListTile(
              title: Text('Metode Pembayaran:'),
              contentPadding: EdgeInsets.all(0.0),
            ),

            RadioListTile(
              title: const Text('Kartu Debit'),
              value: 'Kartu Debit',
              groupValue: _groupValue,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _groupValue = value as String;
                  });
                }
              },
            ),
            RadioListTile(
              title: const Text('Kartu Kredit'),
              value: 'Kartu Kredit',
              groupValue: _groupValue,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _groupValue = value as String;
                  });
                }
              },
            ),
            RadioListTile(
              title: const Text('Transfer Bank'),
              value: 'Transfer Bank',
              groupValue: _groupValue,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _groupValue = value as String;
                  });
                }
              },
            ),
            RadioListTile(
              title: const Text('E-Wallet'),
              value: 'E-Wallet',
              groupValue: _groupValue,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _groupValue = value as String;
                  });
                }
              },
            ),

            // Add more RadioListTile widgets for other payment methods
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Implement checkout functionality
                  //nanti akan dibuat halaman selesai co
                },
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

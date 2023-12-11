import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/BuyBooks/screens/cart_page.dart';
import 'package:lembarpena/BuyBooks/models/book.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Future<List<CartItem>> fetchProduct() async {
    String uname = LoginPage.uname;
    var url = Uri.parse('http://127.0.0.1:8000/show_cart_json/$uname/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<CartItem> listItem = [];
    for (var d in data) {
      if (d != null) {
        listItem.add(CartItem.fromJson(d));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Produk')),
                DataColumn(label: Text('Harga Satuan')),
                DataColumn(label: Text('Jumlah')),
                DataColumn(label: Text('Subtotal Harga')),
              ],
              rows: cartItems.map((product) {
                return DataRow(cells: [
                  DataCell(Text(product['book']['title'])),
                  DataCell(Text(
                      '${product['book']['currency']} ${product['book']['price']}')),
                  DataCell(Text('${product['quantity']}')),
                  DataCell(Text('${product['subtotal']}')),
                ]);
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Total Harga: ${currency} ${totalPrice}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
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
              title: const Text(
                'Kartu Kredit',
              ),
              value: 'Kartu Kredit',
              groupValue: null,
              onChanged: (value) {
                // Handle radio button changes
              },
            ),
            RadioListTile(
              title: const Text('Kartu Debit'),
              value: 'Kartu Debit',
              groupValue: null,
              onChanged: (value) {
                // Handle radio button changes
              },
            ),
            RadioListTile(
              title: const Text('Transfer Bank'),
              value: 'Transfer Bank',
              groupValue: null,
              onChanged: (value) {
                // Handle radio button changes
              },
            ),
            RadioListTile(
              title: const Text('E-Wallet'),
              value: 'E-Wallet',
              groupValue: null,
              onChanged: (value) {
                // Handle radio button changes
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
            ElevatedButton(onPressed: () {}, child: const Text('Berhasil'))
          ],
        ),
      ),
    );
  }
}

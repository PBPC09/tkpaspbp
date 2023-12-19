import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Main/screens/menu.dart';
import 'dart:convert';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/buybooks/models/cart_item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late Future<List<CartItem>> _cartItemsFuture;
  String _groupValue = '';
  late String uname = LoginPage.uname;
  late Future<double> harga;
  double valueHarga = 0;
  TextEditingController alamatController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _cartItemsFuture = fetchProduct();
    harga = fetchHarga();
  }

  Future<List<CartItem>> getCartItems() {
    return fetchProduct();
  }

  Future<double> fetchHarga() async {
    var url =
        Uri.parse('http://localhost:8000/checkoutbook/get_total_harga/$uname/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // if (response.statusCode == 200) {
    var data = jsonDecode(utf8.decode(response.bodyBytes));
    var hargaStr =
        data[0]['total_harga']; // Mengakses nilai dalam array bertingkat
    var harga = double.tryParse(hargaStr) ??
        0.0; // Mengonversi ke double, default ke 0.0 jika gagal
    return harga;
    // } else {
    //   // Handle error atau kembalikan nilai default
    //   return 0.0;
    // }
  }

  Future<List<CartItem>> fetchProduct() async {
    var url = Uri.parse(
        'http://localhost:8000/checkoutbook/show_checkout_json/$uname/');
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

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<CartItem>>(
              future: getCartItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
            FutureBuilder<double>(
              future: harga, // future yang menunggu hasil
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                      'Loading...'); // Tampilkan loading atau widget lain saat menunggu
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Tampilkan error jika ada
                } else {
                  // Tampilkan harga jika data tersedia
                  valueHarga = snapshot.data!;
                  return Text('Total Harga: ${snapshot.data}');
                }
              },
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: alamatController,
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
                onPressed: () async {
                  // Implement checkout functionality
                  final response = await request.postJson(
                    "http://localhost:8000/checkoutbook/checkout_flutter/",
                    jsonEncode({
                      "alamat": alamatController.text,
                      "metode_pembayaran": _groupValue,
                      "total_harga": valueHarga,
                    }),
                  );
                    // Periksa kode status HTTP dari respons
                    if (response['status'] == 'success') {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("CheckOut Berhasil!"),
                        ),
                      );
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage()),
                      ); // Kembali ke halaman sebelumnya
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                        ),
                      );
                    }
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
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
// import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/BuyBooks/models/book.dart';
import 'package:lembarpena/BuyBooks/screens/buybooks_page.dart';
// import 'package:toko_pbp_mobile/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CartFormPage extends StatefulWidget {
  final Book book;
  const CartFormPage({Key? key, required this.book}) : super(key: key);

  @override
  State<CartFormPage> createState() => _CartFormPageState();
}

class _CartFormPageState extends State<CartFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _amount = 0;
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Tambah ke Keranjang',
          ),
        ),
        // backgroundColor: Colors.deepPurple,
        // foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Jumlah Item",
                labelText: "Jumlah Item",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _amount = int.parse(value!);
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Jumlah tidak boleh kosong!";
                }
                if (int.tryParse(value) == null) {
                  return "Jumlah harus berupa angka!";
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                ),
                onPressed: () async {
                  int bookId = widget.book.pk;
                  if (_formKey.currentState!.validate()) {
                    // Kirim ke Django dan tunggu respons
                    final response = await request.postJson(
                        "http://localhost:8000/create/$bookId",
                        jsonEncode(<String, String>{
                          'amount': _amount.toString(),
                        }));
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Produk baru berhasil disimpan!"),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BuyBooksPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Terdapat kesalahan, silakan coba lagi."),
                      ));
                    }
                  }
                },
                child: const Text(
                  "Tambah",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}

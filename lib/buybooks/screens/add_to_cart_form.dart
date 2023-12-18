import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/buybooks/screens/buybooks_page.dart';
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
  int _quantity = 0;
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add To Cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
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
                  _quantity = int.parse(value!);
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
                  backgroundColor:
                      MaterialStateProperty.all(Colors.indigo[900]),
                ),
                onPressed: () async {
                  int bookId = widget.book.pk;
                  if (_formKey.currentState!.validate()) {
                    // Kirim ke Django dan tunggu respons
                    final response = await request.postJson(
                        "http://localhost:8000/buybooks/create-flutter/$bookId/",
                        jsonEncode(<String, dynamic>{
                          'quantity': _quantity,
                        }));
                    if (response['status'] == 'success') {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Produk baru berhasil disimpan!"),
                      ));
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BuyBooksPage()),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
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

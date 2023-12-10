import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CreateCommentPage extends StatefulWidget {
  final int forumHeadId;

  const CreateCommentPage({Key? key, required this.forumHeadId}) : super(key: key);

  @override
  _CreateCommentPageState createState() => _CreateCommentPageState();
}

class _CreateCommentPageState extends State<CreateCommentPage> {
  final _formKey = GlobalKey<FormState>();
  String comment = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Komentar'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Komentar",
                    labelText: "Komentar",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(5.0),
                    // ),
                  ),
                  onSaved: (String? value) {
                    comment = value!;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Komentar tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final response = await request.postJson(
                        "http://127.0.0.1:8000/bookforum/create_comments_flutter/${widget.forumHeadId}",
                        jsonEncode({"answer": comment}),
                      );

                  // Periksa kode status HTTP dari respons
                      if (response['status'] == 'success'){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Komentar berhasil ditambahkan!"),
                          ),
                        );
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Terdapat kesalahan, silakan coba lagi."),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Kirim",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

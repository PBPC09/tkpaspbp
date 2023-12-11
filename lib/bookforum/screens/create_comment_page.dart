import 'package:flutter/material.dart';
import 'package:lembarpena/BookForum/screens/comment_page.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CreateCommentPage extends StatefulWidget {
  final int forumHeadId;
  final String title;
  final String question;
  final int bookId;
  const CreateCommentPage({
    Key? key,
    required this.forumHeadId,
    required this.title,
    required this.question,
    required this.bookId,
  }) : super(key: key);

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
                        // "http://10.0.2.2:8000/bookforum/create_comments_flutter/${widget.forumHeadId}",
                        "http://localhost:8000/bookforum/create_comments_flutter/${widget.forumHeadId}",

                        jsonEncode({"answer": comment}),
                      );

                      // Periksa kode status HTTP dari respons
                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Komentar berhasil ditambahkan!"),
                          ),
                        );
                        // Navigator.pop(context); // Kembali ke halaman sebelumnya
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForumCommentsPage(
                                    forumHeadId: widget.forumHeadId,
                                    bookId: widget.bookId,
                                    question: widget.question,
                                    title: widget.title,
                                  )),
                        ); // Kembali ke halaman sebelumnya
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Terdapat kesalahan, silakan coba lagi."),
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

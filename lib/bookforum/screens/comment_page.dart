import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Authentication/login_page.dart';
import 'dart:convert';

import 'package:lembarpena/BookForum/models/forumcomment.dart';
import 'package:lembarpena/BookForum/screens/create_comment_page.dart';
import 'package:lembarpena/Wishlist/models/book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

// Definisikan model ForumComment Anda di sini atau import dari file model

class ForumCommentsPage extends StatefulWidget {
  final int forumHeadId;
  final String title;
  final String question;
  final int bookId;
  const ForumCommentsPage({
    Key? key,
    required this.forumHeadId,
    required this.title,
    required this.question,
    required this.bookId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForumCommentsPageState createState() => _ForumCommentsPageState();
}

class _ForumCommentsPageState extends State<ForumCommentsPage> {
  List<ForumComment> comments = [];
  // late ForumHead forumHead;
  bool isBookLoaded = false;
  late Book book;
  late String loggedInUser = LoginPage
      .uname; // Tambahkan variabel untuk menyimpan username pengguna yang login

  // Not working
  // Future<void> fetchForumHead() async {
  //   var url = Uri.parse(
  //       'http://127.0.0.1:8000/bookforum/forumhead/json/${widget.forumHeadId}');
  //   var response = await http.get(url);
  //   var data = jsonDecode(utf8.decode(response.bodyBytes));
  //   forumHead = ForumHead.fromJson(data);
  // }

  Future<Book> fetchBookDetails(int bookId) async {
    var url =
        // Uri.parse('http://10.0.2.2:8000/bookforum/book_details/json/$bookId');
        Uri.parse('http://localhost:8000/bookforum/book_details/json/$bookId');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Book.fromJson(data[0]);
    } else {
      throw Exception('Failed to load book');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBookDetails(widget.bookId).then((bookDetails) {
      setState(() {
        book = bookDetails; // Menetapkan hasil ke variabel book
        isBookLoaded = true;
      });
    });
    // fetchForumHead(); // Memanggil fungsi fetchForumHead

    fetchComments();
  }

  Future<void> fetchComments() async {
    var url = Uri.parse(
        // 'http://10.0.2.2:8000/bookforum/uniquecomments/json/${widget.forumHeadId}');
        'http://localhost:8000/bookforum/uniquecomments/json/${widget.forumHeadId}');

    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // Konversi data JSON ke list of ForumComment objects
    // Sesuaikan dengan struktur model ForumComment Anda
    setState(() {
      comments =
          List<ForumComment>.from(data.map((x) => ForumComment.fromJson(x)));
    });
  }

  Future<void> deleteComment(
      CookieRequest request, String username, int commentId) async {
    // Sesuaikan dengan URL API Anda
    // final response = await request.postJson('http://10.0.2.2:8000/bookforum/delete_comments_flutter/$username/$commentId',
    final response = await request.postJson(
        'http://localhost:8000/bookforum/delete_comments_flutter/$username/$commentId',
        jsonEncode({}));

    if (response['status'] == 'success') {
      // Handle berhasil menghapus
      fetchComments(); // Muat ulang komentar
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Komentar Forum'),
      ),
      body: !isBookLoaded
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      widget.title, // Judul Forum
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.question, // Pertanyaan
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      child: Text(
                        book.fields.title, // Judul Buku
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 13, 90, 154)),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(book.fields.title),
                              content: SingleChildScrollView(
                                // Membuat konten scrollable
                                child: Text(
                                  book.fields.description,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: comments.isEmpty
                          ? const Text("Belum ada Komentar")
                          : ListView.builder(
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                var comment = comments[index];
                                var date = DateFormat('yyyy-MM-dd')
                                    .format(comment.fields.date);
                                return Card(
                                  child: ListTile(
                                    title: Text(comment.fields.answer),
                                    subtitle: Text(
                                        "Dikirim oleh: ${comment.fields.user} pada $date"),
                                    trailing:
                                        comment.fields.user == loggedInUser
                                            ? IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                  deleteComment(request,
                                                      loggedInUser, comment.pk);
                                                },
                                              )
                                            : null,
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CreateCommentPage(
                    forumHeadId: widget.forumHeadId,
                    title: widget.title,
                    question: widget.question,
                    bookId: widget.bookId)),
          );
        },
        tooltip: 'Tambah Komentar',
        child: const Icon(Icons.add),
      ),
    );
  }
}

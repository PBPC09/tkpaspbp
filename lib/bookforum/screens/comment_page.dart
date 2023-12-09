import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Authentication/login_page.dart';
import 'dart:convert';

import 'package:lembarpena/BookForum/models/forumcomment.dart';
import 'package:lembarpena/BookForum/models/forumhead.dart';
import 'package:lembarpena/Wishlist/models/book.dart';

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
        Uri.parse('http://127.0.0.1:8000/bookforum/book_details/json/$bookId');
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
        'http://127.0.0.1:8000/bookforum/uniquecomments/json/${widget.forumHeadId}');
    var response = await http.get(url);
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // Konversi data JSON ke list of ForumComment objects
    // Sesuaikan dengan struktur model ForumComment Anda
    setState(() {
      comments =
          List<ForumComment>.from(data.map((x) => ForumComment.fromJson(x)));
    });
  }

  Future<void> deleteComment(String username, int commentId) async {
    var url = Uri.parse(
        'http://127.0.0.1:8000/bookforum/delete_comments/$username/$commentId'); // Sesuaikan dengan URL API Anda
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      // Handle berhasil menghapus
      fetchComments(); // Muat ulang komentar
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komentar Forum'),
      ),
      body: !isBookLoaded
        ? const Center(child: CircularProgressIndicator())
        : comments.isEmpty
          ? Column(
            children: [
              ListTile(
                  title: Text(widget.title + widget.question), // Judul ForumHead
                  subtitle: Text(book.fields.title +
                      book.fields.description), // Judul Buku
                ),
              const Text("Belum ada Komentar"),
            ],
          )           
          : Column(
              children: [
                ListTile(
                  title: Text(widget.title + widget.question), // Judul ForumHead
                  subtitle: Text(book.fields.title +
                      book.fields.description), // Judul Buku
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      var comment = comments[index];
                      return Card(
                        child: ListTile(
                          title: Text(comment.fields.answer),
                          subtitle: Text(
                              "Dikirim oleh: ${comment.fields.user} pada ${comment.fields.date}"),
                          trailing: comment.fields.user ==
                                  loggedInUser // Ganti dengan username pengguna yang login
                              ? IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Implementasikan fungsi untuk menghapus komentar
                                    deleteComment(loggedInUser, comment.pk);
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
    );
  }
}

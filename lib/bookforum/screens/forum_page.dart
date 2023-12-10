import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Wishlist/models/book.dart';
import 'package:lembarpena/Authentication/login_page.dart';
import 'dart:convert';
import 'package:lembarpena/BookForum/screens/create_forum_page.dart'; // Pastikan import ini benar
import 'package:lembarpena/BookForum/models/forumhead.dart';
import 'package:lembarpena/BookForum/screens/comment_page.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  late String loggedInUser = LoginPage.uname;  
  List<ForumHead> forumHeads = [];


  Future<List<ForumHead>> fetchForumHeads() async {
    var url = Uri.parse('http://127.0.0.1:8000/bookforum/forum/json/'); // Sesuaikan dengan URL endpoint Anda
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    forumHeads = [];
    for (var d in data) {
      forumHeads.add(ForumHead.fromJson(d));
    }
    return forumHeads;
  }


  Future<void> deleteQuestion(CookieRequest request,String username, int id) async {
    final response = await request.postJson('http://127.0.0.1:8000/bookforum/delete_question_flutter/$username/$id', 
    jsonEncode({}));

    if (response['status'] == 'success') {
      // Handle berhasil menghapus
        setState(() {
          // Memuat ulang data ForumHead
          fetchForumHeads().then((newData) {
            // Update state dengan data yang baru
            setState(() {
              forumHeads = newData;
            });
          });
        }); // Muat ulang komentar
    } else {
      // Handle error

    }
      // var url = Uri.parse('http://127.0.0.1:8000/bookforum/delete_question/$username/$id');
      // var response = await http.delete(url);

      // if (response.statusCode == 201) {
      //   setState(() {
      //     // Memuat ulang data ForumHead
      //     fetchForumHeads().then((newData) {
      //       // Update state dengan data yang baru
      //       setState(() {
      //         forumHeads = newData;
      //       });
      //     });
      //   });
      // } else {
      //   // Handle error
      // }
  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum LembarPena'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchForumHeads(),
        builder: (context, AsyncSnapshot<List<ForumHead>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Tidak ada forum diskusi.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var forumHeadData = snapshot.data![index];
                var forumHeadFields = forumHeadData.fields;

                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForumCommentsPage(
                            forumHeadId: forumHeadData.pk,
                            title: forumHeadFields.title,
                            question: forumHeadFields.question,
                            bookId: forumHeadData.fields.bookId // Misalnya
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            forumHeadFields.title, // Judul Topik
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Buku: ${forumHeadFields.book}"), // Buku
                          Text("Penanya: ${forumHeadFields.user}"), // Penanya
                          Text("Tanggal: ${forumHeadFields.date}"), // Tanggal
                          // Tampilkan jumlah komentar jika tersedia
                          Text("Jumlah Komentar: ${forumHeadFields.commentCounts}"),
                          // Text("forumHeadFields: ${forumHeadFields.user}"),
                          // Text("loggedIn: $loggedInUser"),

                          if (forumHeadFields.user == loggedInUser) // Cek apakah pengguna yang login adalah pembuat
                            ElevatedButton(
                              onPressed: () {
                                deleteQuestion(request,forumHeadFields.user, forumHeadData.pk);
                              },
                              child: const Text('Hapus'),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigasi ke CreateForumPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateForumPage()),
            );
          },
          child: const Icon(Icons.add),
          tooltip: 'Buat Forum Baru',
        ),
      );
  }
}

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
import 'package:intl/intl.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  late String loggedInUser = LoginPage.uname;  
  List<ForumHead> forumHeads = [];
  bool isChecked = false;


  Future<List<ForumHead>> fetchForumHeads() async {
    // var url = Uri.parse('http://10.0.2.2:8000/bookforum/forum/json/'); // Sesuaikan dengan URL endpoint Anda
    var url = Uri.parse('http://localhost:8000/bookforum/forum/json/'); // Sesuaikan dengan URL endpoint Anda
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

  Future<List<ForumHead>> fetchForumHeadsPopular() async {
    // var url = Uri.parse('http://10.0.2.2:8000/bookforum/forum/json/'); // Sesuaikan dengan URL endpoint Anda
    var url = Uri.parse('http://localhost:8000/bookforum/show_forum_json_popular_only/'); // Sesuaikan dengan URL endpoint Anda
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
    // final response = await request.postJson('http://10.0.2.2:8000/bookforum/delete_question_flutter/$username/$id', 
    final response = await request.postJson('http://localhost:8000/bookforum/delete_question_flutter/$username/$id', 
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
  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum LembarPena'),
      ),
      drawer: const LeftDrawer(),
      body: Column(
          children : [
            ListTile(
            title: const Text("Tampilkan Forum Populer"),
            leading: Checkbox(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
          ),
          Expanded(
              child : FutureBuilder(
              future: isChecked? fetchForumHeadsPopular() : fetchForumHeads(),
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
                              crossAxisAlignment: CrossAxisAlignment.center, // Tengah
                              children: [
                                Text(
                                  forumHeadFields.title, // Judul Topik
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  
                                  ),
                                  
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.book), // Ikon Buku
                                    Expanded(
                                      child: Text(
                                        forumHeadFields.book,
                                        overflow: TextOverflow.ellipsis, // Tambahkan ellipsis
                                      ),
                                    ),                              
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.calendar_today), // Ikon Kalender
                                    Text(DateFormat('yyyy-MM-dd').format(forumHeadFields.date)), // Format Tanggal
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.person), // Ikon Penanya
                                    Text(forumHeadFields.user),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.comment), // Ikon Komentar
                                    Text("${forumHeadFields.commentCounts}"),
                                  ],
                                ),
                                if (forumHeadFields.user == loggedInUser) // Tombol Hapus
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(Icons.delete), // Ikon Tong Sampah
                                      onPressed: () {
                                        deleteQuestion(request, forumHeadFields.user, forumHeadData.pk);
                                      },
                                    ),
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
          )
        ]
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

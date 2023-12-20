import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/bookforum/screens/create_forum_page.dart';
import 'package:lembarpena/bookforum/models/forumhead.dart';
import 'package:lembarpena/bookforum/screens/comment_page.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  late String loggedInUser = LoginPage.uname;
  List<ForumHead> forumHeads = [];
  bool isChecked = false;

  Future<List<ForumHead>> fetchForumHeads() async {
    // var url = Uri.parse('http://10.0.2.2:8000/bookforum/forum/json/'); // Sesuaikan dengan URL endpoint Anda
    var url = Uri.parse(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/bookforum/forum/json/'); // Sesuaikan dengan URL endpoint Anda
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
    var url = Uri.parse(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/bookforum/show_forum_json_popular_only/'); // Sesuaikan dengan URL endpoint Anda
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

  Future<void> deleteQuestion(
      CookieRequest request, String username, int id) async {
    // final response = await request.postJson('http://10.0.2.2:8000/bookforum/delete_question_flutter/$username/$id',
    final response = await request.postJson(
        'https://lembarpena-c09-tk.pbp.cs.ui.ac.id/bookforum/delete_question_flutter/$username/$id',
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
        title: const Text('Forum Buku', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[900],
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SwitchListTile(
            title: const Text("Tampilkan forum buku populer saja"),
            value: isChecked,
            onChanged: (bool value) {
              setState(() {
                isChecked = value;
              });
            },
            secondary: const Icon(Icons.filter_list),
          ),
          Expanded(
            child: FutureBuilder(
              future: isChecked ? fetchForumHeadsPopular() : fetchForumHeads(),
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
                        elevation: 4.0,
                        margin: const EdgeInsets.all(8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForumCommentsPage(
                                  forumHeadId: forumHeadData.pk,
                                  title: forumHeadFields.title,
                                  question: forumHeadFields.question,
                                  bookId: forumHeadData.fields.bookId,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  forumHeadFields.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.indigo,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  forumHeadFields.book,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Penanya: ${forumHeadFields.user}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Tanggal: ${DateFormat('dd MMMM yyyy').format(forumHeadFields.date)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.comment, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                            "${forumHeadFields.commentCounts} Komentar"),
                                      ],
                                    ),
                                    if (forumHeadFields.user == loggedInUser)
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            size: 20, color: Colors.redAccent),
                                        onPressed: () {
                                          deleteQuestion(
                                              request,
                                              forumHeadFields.user,
                                              forumHeadData.pk);
                                        },
                                      ),
                                  ],
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
          ),
        ]),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateForumPage()),
          );
        },
        backgroundColor: Colors.indigo[900],
        mini: true,
        child: const Icon(Icons.add,
            color: Colors.white), // Mengubah ukuran tombol menjadi mini
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        backgroundColor: Colors.indigo,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: const Color.fromARGB(255, 156, 143, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Ganti dengan path gambar yang sesuai
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Ganti dengan path gambar yang sesuai
            label: 'Explore Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum), // Ganti dengan path gambar yang sesuai
            label: 'Book Forum',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MyHomePage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ExploreBooksPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ForumPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

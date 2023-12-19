import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'package:lembarpena/AdminRegisterBook/models/book.dart';
import 'package:lembarpena/wishlist/screens/detail_buku.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ExploreBooksPage extends StatefulWidget {
  const ExploreBooksPage({Key? key}) : super(key: key);

  @override
  _ExploreBooksPageState createState() => _ExploreBooksPageState();
}

class _ExploreBooksPageState extends State<ExploreBooksPage> {
  List<Book> books = [];
  Set<int> wishlistBookIds = {};
  String uname = LoginPage.uname;
  String dropdownValue = 'Semua';
  // ignore: prefer_typing_uninitialized_variables
  var filteredData;
  @override
  void initState() {
    super.initState();
    fetchBooks('All Rating'); // Panggil dengan rating awal
    fetchWishlist();
  }

  Future<void> deleteQuestion(CookieRequest request, int bookId) async {
    int pkWishlist = 0;
    for (var data in filteredData) {
      if (data["fields"]["book_id"] == bookId) {
        pkWishlist = data["pk"];
        break;
      }
    }

    final response = await request.postJson(
        'http://localhost:8000/wishlist/delete_wishlist_item_flutter/$pkWishlist/',
        jsonEncode({}));

    if (response['status'] == 'success') {
      setState(() {
        wishlistBookIds.remove(bookId);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Buku telah dihapus dari wishlist!")));
      });
    } else {
      // Handle error
    }
  }

  Future<void> fetchBooks(String rating) async {
    Map<String, String> queryParams = {};
    if (rating == '≥ 4.0') {
      queryParams['rating_gte'] = '4';
    } else if (rating == '< 4.0') {
      queryParams['rating_lt'] = '4';
    }
    var url = Uri.parse(
        'http://localhost:8000/buybooks/show_books_json/?rating=$queryParams');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    setState(() {
      books = List<Book>.from(data.map((x) => Book.fromJson(x)));
    });
  }

  Future<void> fetchWishlist() async {
    var url = Uri.parse('http://localhost:8000/wishlist/mywishlist/json');
    var response =
        await http.get(url, 
        headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    filteredData = data.where((x) => x['fields']['user'] == uname).toList();
    setState(() {
      wishlistBookIds =
          Set<int>.from(filteredData.map((x) => x['fields']["book_id"]));
    });
  }

  Future<void> addToWishlist(
    CookieRequest request, int bookId, int preference) async {
    final response = await request.postJson(
      "http://localhost:8000/wishlist/add_to_wishlist_flutter/",
      jsonEncode({
        'username': uname, 
        "book_id": bookId, 
        'preference': preference}),
    );

    if (response['status'] == 'success') {
      setState(() {
        wishlistBookIds.add(bookId);
        fetchWishlist();
      });
      // fetchWishlist();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Buku berhasil ditambahkan ke Wishlist!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error adding book to wishlist')));
    }
  }

  List<Book> getFilteredBooks() {
    if (dropdownValue == 'Wishlist Saya') {
      return books.where((book) => wishlistBookIds.contains(book.pk)).toList();
    }else{
      return books;
    }
  }

  void showPreferenceDialog(CookieRequest request, int bookId) async {
    int? preference = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('How much do you like this book?'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: const Text('Not Interested'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 2);
              },
              child: const Text('Maybe Later'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 3);
              },
              child: const Text('Interested'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 4);
              },
              child: const Text('Really Want It'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 5);
              },
              child: const Text('Must Have'),
            ),
          ],
        );
      },
    );

    if (preference != null) {
      addToWishlist(request, bookId, preference);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[900],
      ),
      drawer: const LeftDrawer(),
      body: 
      Column(
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward, size: 20), // Ukuran icon yang lebih besar
            elevation: 16,
            style: const TextStyle(color: Colors.indigoAccent, fontSize: 20), // Ukuran font yang lebih besar
            underline: Container(
              color: Colors.indigoAccent[900],
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Semua', 'Wishlist Saya']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding( // Padding untuk item
                  padding: EdgeInsets.symmetric(vertical: 10), // Tingkatkan padding secara vertikal
                  child: Text(value),
                ),
              );
            }).toList(),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: getFilteredBooks().length,
              itemBuilder: (_, index) {
                Book book =  getFilteredBooks()[index];
                bool isInWishlist = wishlistBookIds.contains(book.pk);
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.fields.title,
                            style: const TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("Author: ${book.fields.author}"),
                        const SizedBox(height: 8),
                        Text("Rating: ${book.fields.rating}"),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.info_outline),
                              color: Colors.blue[400],
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailBukuPage(book: book),
                                ));
                              },
                            ),
                            IconButton(
                              icon: Icon(isInWishlist
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              color: isInWishlist ? Colors.red : Colors.grey,
                              onPressed: () {
                                if (!isInWishlist) {
                                  showPreferenceDialog(request, book.pk);
                                } else {
                                  deleteQuestion(request, book.pk);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
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

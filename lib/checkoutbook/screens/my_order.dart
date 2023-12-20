import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'dart:convert';

import 'package:lembarpena/checkoutbook/models/checkout.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  late Future<List<Checkoutbook>> futureOrder;
  late String loggedInUser = LoginPage.uname;
  @override
  void initState() {
    super.initState();
    futureOrder = fetchOrder();
  }

  Future<List<Checkoutbook>> fetchOrder() async {
    var url =
        Uri.parse('https://lembarpena-c09-tk.pbp.cs.ui.ac.id/checkoutbook/get_order_json_all/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Checkoutbook> fetchedOrder = [];
    for (var item in data) {
      // Anda mungkin perlu menyesuaikan ini sesuai dengan struktur data yang benar
      // Pastikan Anda memiliki properti yang sesuai dalam Checkoutbook
      if (item['fields']['user'] == loggedInUser) {
        fetchedOrder.add(Checkoutbook.fromJson(item));
      }
    }
    return fetchedOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan Saya'),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Checkoutbook>>(
          future: futureOrder,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text('Anda belum memesan apapun!'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Checkoutbook order = snapshot.data![index];
                  return Card(
                    elevation: 2.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text("Checkout $index"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Alamat: ${order.fields.alamat}"),
                          Text(
                              "Metode Pembayaran: ${order.fields.metodePembayaran}"),
                          Text(
                              "Total Price: SAR ${order.fields.totalPrice.toStringAsFixed(2)}"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // currentIndex: 2,
        backgroundColor: Colors.indigo,
        selectedItemColor:const Color.fromARGB(255, 156, 143, 255),
        unselectedItemColor: const Color.fromARGB(255, 156, 143, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
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

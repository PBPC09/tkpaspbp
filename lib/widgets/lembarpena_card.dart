import 'package:flutter/material.dart';
import 'package:lembarpena/bookforum/screens/forumpage.dart';
import 'package:lembarpena/registerbook/screens/adminpage.dart';
import 'package:lembarpena/screens/menu.dart';
import 'package:lembarpena/wishlist/models/book.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';

class ShopCard extends StatelessWidget {
  final ShopItem item;

  const ShopCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
          if (item.name == "Home") {
            // TODO: Implement home button functionality.
            // TODO: Implement cart button functionality.
          } else if (item.name == "Buy Books") {
            // TODO: Implement buy books button functionality.
          } else if (item.name == "Book Forum") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForumPage()));
            // TODO: Implement forum button functionality.
          } else if (item.name == "My Order") {
            // TODO: Implement my order button functionality.
          } else if (item.name == "Admin Page") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminHomePage()));
          } else if (item.name == "Logout") {}
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

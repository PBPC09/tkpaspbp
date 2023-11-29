import 'package:flutter/material.dart';
import 'package:lembarpena/bookforum/screens/forumpage.dart';
import 'package:lembarpena/screens/menu.dart';

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
          if (item.name == "HOME") {
            // TODO: Implement home button functionality.
          } else if (item.name == "EXPLORE BOOK") {
            // TODO: Implement explore book button functionality.
          } else if (item.name == "WISHLIST") {
            // TODO: Implement wishlist button functionality.
          } else if (item.name == "Cart") {
            // TODO: Implement cart button functionality.
          } else if (item.name == "Buy Books") {
            // TODO: Implement buy books button functionality.
          } else if (item.name == "Book Forum") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForumPage()));
            // TODO: Implement forum button functionality.
          } else if (item.name == "MY ORDER") {
            // TODO: Implement my order button functionality.
          } else if (item.name == "LOGOUT") {
          }
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
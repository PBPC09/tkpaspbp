import 'package:flutter/material.dart';
import 'package:lembarpena/BookForum/screens/forum_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/Authentication/login_page.dart';
import 'package:lembarpena/Wishlist/screens/explore_book.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';

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
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
          } else if (item.name == "Explore Book") {
            // TODO: Implement explore book button functionality.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExploreBooksPage(),
              ),
            );
          } else if (item.name == "WISHLIST") {
            // TODO: Implement wishlist button functionality.
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const WishlistPage(),
            //   ));
          } else if (item.name == "CART") {
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminPage()));
          } else if (item.name == "Logout") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
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

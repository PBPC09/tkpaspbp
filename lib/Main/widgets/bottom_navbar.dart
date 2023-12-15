// import 'package:flutter/material.dart';
// import 'package:lembarpena/BookForum/screens/forum_page.dart';
// import 'package:lembarpena/Main/screens/menu.dart';
// import 'package:lembarpena/Wishlist/screens/my_wishlist.dart';

// class BottomNavbar extends StatefulWidget {
//   @override
//   _BottomNavbarState createState() => _BottomNavbarState();
// }

// class _BottomNavbarState extends State<BottomNavbar> {
//   int _selectedIndex = 0;

//   void _onItemTapped(BuildContext context, int index) {
//     setState(() {
//       _selectedIndex = index;
//     });

//     switch (index) {
//       case 0:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
//         break;
//       case 1:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistPage(wishlist: [],)));
//         break;
//       case 2:
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const ForumPage()));
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Wishlist',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.forum),
//             label: 'BookForum',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: (index) => _onItemTapped(context, index),
//       ),
//     );
//   }
// }

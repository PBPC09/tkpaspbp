import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/screens/book_collections.dart';
import 'package:lembarpena/AdminRegisterBook/screens/order_notifications.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_left_drawer.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_menu_card.dart';
import 'package:lembarpena/Authentication/login_page.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  final List<AdminMenuItem> pages = [
    AdminMenuItem("Book Form", Icons.add_circle, Colors.indigo),
    AdminMenuItem("Book Collections", Icons.book, Colors.indigo),
    AdminMenuItem("Order Notifications", Icons.notifications, Colors.indigo),
    AdminMenuItem("Logout", Icons.logout, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    String uname = LoginPage.uname;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, $uname!'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    'image/imagecover.jpg',
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 400,
                    color: Color.fromARGB(255, 1, 37, 158).withOpacity(0.5),
                  ),
                  const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          'Welcome to LembarPena',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      // Tambahkan teks lainnya jika diperlukan
                    ],
                  )
                ],
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: pages.map((AdminMenuItem item) {
                  return AdminMenuCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Book Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Order Notifications',
          ),
        ],
        onTap: (index) {
          // Logika untuk mengganti halaman saat tab navigasi diklik
          switch (index) {
            case 0:
              // Navigasi ke Dashboard
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => AdminPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 1:
              // Navigasi ke halaman Books
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const BookCollectionsPage(),
                  transitionDuration: Duration.zero,
                ),
              );
              break;
            case 2:
              // Navigasi ke halaman Notifications
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const NotificationPage(),
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

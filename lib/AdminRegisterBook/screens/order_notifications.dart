import 'package:flutter/material.dart';
import 'package:lembarpena/AdminRegisterBook/models/Notification.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
import 'package:lembarpena/AdminRegisterBook/screens/book_collections.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Future<List<OrderNotifications>> fetchNotifications(request) async {
    var data =
        await request.get('http://localhost:8000/registerbook/get-notif/');

    // Convert JSON data to Notification objects
    List<OrderNotifications> notificationList = [];
    for (var d in data) {
      if (d != null) {
        notificationList.add(OrderNotifications.fromJson(d));
      }
    }
    return notificationList;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchNotifications(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Tidak ada orderan masuk.",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         DetailItemPage(item: snapshot.data![index]),
                    //   ),
                    // );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pesanan masuk dari ${snapshot.data![index].fields.buyer}.",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("${snapshot.data![index].fields.message}"),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
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

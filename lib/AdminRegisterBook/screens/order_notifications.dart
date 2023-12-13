import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/AdminRegisterBook/models/notification.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
import 'package:lembarpena/AdminRegisterBook/screens/book_collections.dart';
import 'package:lembarpena/AdminRegisterBook/widgets/admin_left_drawer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<OrderNotifications> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  void fetchNotifications() async {
    final response = await http.get(
        Uri.parse('http://localhost:8000/registerbook/get-notif/'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        notifications = orderNotificationsFromJson(response.body);
        notifications
            .sort((a, b) => b.fields.timestamp.compareTo(a.fields.timestamp));
      });
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  void deleteNotification(int notifId) async {
    final response = await http.delete(Uri.parse(
        'http://localhost:8000/registerbook/delete-notification/$notifId/'));

    if (response.statusCode == 200) {
      setState(() {
        notifications.removeWhere((notif) => notif.pk == notifId);
      });
    } else {
      throw Exception('Failed to delete notification');
    }
  }

  void markNotificationAsRead(int notifId) async {
    final response = await http.get(Uri.parse(
        'http://localhost:8000/registerbook/mark-notification-read/$notifId/'));

    if (response.statusCode == 200) {
      setState(() {
        notifications.firstWhere((notif) => notif.pk == notifId).fields.isRead =
            true;
      });
    } else {
      throw Exception('Failed to mark notification as read');
    }
  }

  void markAllNotificationsAsRead() async {
    final response = await http.get(Uri.parse(
        'http://localhost:8000/registerbook/mark-all-notifications-read/'));

    if (response.statusCode == 200) {
      setState(() {
        for (var notif in notifications) {
          notif.fields.isRead = true;
        }
      });
    } else {
      throw Exception('Failed to mark all notifications as read');
    }
  }

  @override
  Widget build(BuildContext context) {
    int unreadNotificationsCount =
        notifications.where((n) => !n.fields.isRead).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Notifications${unreadNotificationsCount > 0 ? ' ($unreadNotificationsCount)' : ''}',
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.mark_email_read),
            onPressed: () => markAllNotificationsAsRead(),
          ),
        ],
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: notifications.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var notification = notifications[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  elevation: 4,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    side: notification.fields.isRead
                        ? BorderSide.none
                        : BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(notification.fields.message),
                    subtitle:
                        Text('From: ${notification.fields.buyer.toString()}'),
                    tileColor: notification.fields.isRead
                        ? Colors.white
                        : Colors.grey[300],
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteNotification(notification.pk),
                        ),
                        IconButton(
                          icon: const Icon(Icons.mark_email_read,
                              color: Colors.blue),
                          onPressed: () =>
                              markNotificationAsRead(notification.pk),
                        ),
                      ],
                    ),
                  ),
                );
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

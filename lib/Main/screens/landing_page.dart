import 'package:flutter/material.dart';
import 'package:lembarpena/Authentication/login_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // late List<Item> _data;

  // @override
  // void initState() {
  //   super.initState();
  //   _data = generateAccordionItems();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lembar Pena'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Placeholder(
                  fallbackHeight: 200,
                ),
                Text(
                  'Nikmati buku, semua dalam 1 aplikasi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            buildHorizontalScrollCards(),
            const SizedBox(height: 20),
            const Text(
              'FREQUENTLY ASKED QUESTION',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildAccordion(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text('Let\'s Get Started'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalScrollCards() {
    List<Widget> cards = [
      buildCard('Beli Buku', 'Perluas cakrawala, miliki buku yang hendak Anda baca'),
      buildCard('Simpan Keinginan', 'Temukan bacaan terbaik dan simpan pada koleksi Anda!'),
      buildCard('Lihat Profil Buku', 'Amati profil buku-buku terbaik dan bagaimana mereka akan menghibur Anda!'),
      buildCard('Forum Buku', 'Temukan komunitas yang akan membantu Anda memahami bacaan terbaik!'),
    ];

    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cards,
      ),
    );
  }

  Widget buildCard(String title, String description) {
    return Card(
      child: Container(
        width: 160,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }

  Widget _buildAccordion() {
    return Column(
      children: <Item>[
        Item(headerValue: 'Apa itu LembarPena', expandedValue: 'LembarPena adalah sebuah aplikasi marketplace belanja buku yang memungkinkan Anda untuk menjelajahi, mencari, dan membeli berbagai jenis buku secara online. Kami menyediakan akses ke koleksi buku yang luas, termasuk buku-buku terbaru, buku terlaris, buku bekas, dan banyak lagi. Dengan LembarPena, Anda dapat dengan mudah menemukan buku-buku favorit Anda dan melakukan pembelian secara praktis melalui aplikasi kami.'),
        Item(headerValue: 'Apa itu Fitur Forum Buku di LembarPena?', expandedValue: 'Fitur Forum Buku di LembarPena adalah wadah interaktif tempat pengguna aplikasi dapat berpartisipasi dalam diskusi, berbagi pendapat, dan berkomunikasi tentang buku. Ini adalah ruang online di mana pembaca, penulis, dan penggemar buku dapat bertukar pikiran, merekomendasikan buku, dan berbicara tentang berbagai aspek buku yang mereka baca.'),
        Item(headerValue: ' Apakah Wishlist Book bersifat pribadi atau dapat dibagikan dengan pengguna lain?', expandedValue: 'Wishlist Book pada LembarPena</strong> bersifat pribadi secara default. Ini berarti daftar buku yang disimpan hanya dapat diakses oleh pengguna yang menyimpannya.'),
      ].map<Widget>((Item item) {
        return ExpansionTile(
          title: Text(item.headerValue),
          children: <Widget>[
            ListTile(
              title: Text(item.expandedValue),
            )
          ],
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
  });

  String expandedValue;
  String headerValue;
}
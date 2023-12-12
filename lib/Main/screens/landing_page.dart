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
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/imagecover.jpg',
                  height: 400,
                  fit: BoxFit
                      .cover, // Menyesuaikan bagaimana gambar diisi dalam ruang yang tersedia
                ),
                Container(
                  height: 400,
                  color: Color.fromARGB(255, 1, 37, 158)
                      .withOpacity(0.5), // Warna dengan opacity
                ),
                const Column(
                  children: [
                    Text(
                      'Nikmati buku,',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'semua dalam 1 aplikasi',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
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

  Widget buildCard(String title, String description) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: Container(
        width: 300,
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(description, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHorizontalScrollCards() {
    List<Widget> cards = [
      buildCard(
          'Beli Buku', 'Perluas cakrawala, miliki buku yang hendak Anda baca'),
      buildCard('Simpan Keinginan',
          'Temukan bacaan terbaik dan simpan pada koleksi Anda!'),
      buildCard('Lihat Profil Buku',
          'Amati profil buku-buku terbaik dan bagaimana mereka akan menghibur Anda!'),
      buildCard('Forum Buku',
          'Temukan komunitas yang akan membantu Anda memahami bacaan terbaik!'),
    ];

    return SizedBox(
      height: 175,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cards,
      ),
    );
  }

  Widget _buildAccordion() {
    return Column(
      children: <Item>[
        Item(
            headerValue: 'Apa itu LembarPena',
            expandedValue:
                'LembarPena adalah sebuah aplikasi marketplace belanja buku yang memungkinkan Anda untuk menjelajahi, mencari, dan membeli berbagai jenis buku secara online. Kami menyediakan akses ke koleksi buku yang luas, termasuk buku-buku terbaru, buku terlaris, buku bekas, dan banyak lagi. Dengan LembarPena, Anda dapat dengan mudah menemukan buku-buku favorit Anda dan melakukan pembelian secara praktis melalui aplikasi kami.'),
        Item(
            headerValue: 'Apa itu Fitur Forum Buku di LembarPena?',
            expandedValue:
                'Fitur Forum Buku di LembarPena adalah wadah interaktif tempat pengguna aplikasi dapat berpartisipasi dalam diskusi, berbagi pendapat, dan berkomunikasi tentang buku. Ini adalah ruang online di mana pembaca, penulis, dan penggemar buku dapat bertukar pikiran, merekomendasikan buku, dan berbicara tentang berbagai aspek buku yang mereka baca.'),
        Item(
            headerValue:
                ' Apakah Wishlist Book bersifat pribadi atau dapat dibagikan dengan pengguna lain?',
            expandedValue:
                'Wishlist Book pada LembarPena bersifat pribadi secara default. Ini berarti daftar buku yang disimpan hanya dapat diakses oleh pengguna yang menyimpannya.'),
      ].map<Widget>((Item item) {
        return ExpansionTile(
          title: Text(item.headerValue,
              textAlign: TextAlign.left, style: const TextStyle(fontSize: 18)),
          children: <Widget>[
            ListTile(
              title: Text(
                item.expandedValue,
                textAlign: TextAlign.justify,
              ),
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

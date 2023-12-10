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
      buildCard('Judul 1', 'Deskripsi singkat 1'),
      buildCard('Judul 2', 'Deskripsi singkat 2'),
      buildCard('Judul 3', 'Deskripsi singkat 3'),
      buildCard('Judul 4', 'Deskripsi singkat 4'),
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
        Item(headerValue: 'Pertanyaan 1', expandedValue: 'Jawaban untuk pertanyaan 1.'),
        Item(headerValue: 'Pertanyaan 2', expandedValue: 'Jawaban untuk pertanyaan 2.'),
        Item(headerValue: 'Pertanyaan 3', expandedValue: 'Jawaban untuk pertanyaan 3.'),
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
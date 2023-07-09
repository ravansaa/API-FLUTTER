import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api/halaman.dart';
import 'dart:convert';

class Depan extends StatelessWidget {
  final String apiUrl =
      "https://indonesia-public-static-api.vercel.app/api/volcanoes";

  const Depan({Key? key}) : super(key: key);

  Future<dynamic> _fecthDepan() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang'),
      ),
      body: FutureBuilder<dynamic>(
        future: _fecthDepan(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/image/gunung_image.png',
                      width: 500,
                      height: 300,
                    ),
                  ),
                  const Text(
                    'Gunung di Indonesia',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Halaman(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Lihat Gunung',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

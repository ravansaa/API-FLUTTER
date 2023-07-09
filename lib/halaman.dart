import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Halaman extends StatelessWidget {
  final String apiUrl =
      "https://indonesia-public-static-api.vercel.app/api/volcanoes";

  const Halaman({Key? key}) : super(key: key);

  Future<List<dynamic>> _fetchHalaman() async {
    var result = await http.get(Uri.parse(apiUrl));
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gunung di Indonesia'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchHalaman(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var gunungData = snapshot.data[index];

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.terrain, size: 40),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gunung: ${gunungData['nama']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Bentuk: ${gunungData['bentuk']}',
                        ),
                        Text(
                          'Geolokasi: ${gunungData['geolokasi']}',
                        ),
                        Text(
                          'Letusan terakhir: ${gunungData['estimasi_letusan_terakhir']}',
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "~ ${gunungData['tinggi_meter']} meter",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

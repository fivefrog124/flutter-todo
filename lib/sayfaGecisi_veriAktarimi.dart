// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

get_api() async {
  var url = Uri.http('http://192.168.1.6/sil.php?id=4');
  var response = await http.get(url);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GirisEkrani(),
    );
  }
}

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({super.key});

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        margin: const EdgeInsets.all(300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Giriş Sayfası'),
            TextFormField(
              controller: c1,
            ),
            TextFormField(
              controller: c2,
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilEkrani(
                            username: c1.text,
                            password: c2.text,
                          ),
                        ),
                      );
                    },
                    child: const Text('Giriş Yap'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfilEkrani extends StatefulWidget {
  var username, password;
  ProfilEkrani({this.username, this.password});

  @override
  State<ProfilEkrani> createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            const Text('Profil Sayfası'),
            Text(widget.username),
            Text(widget.password),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Çıkış Yap'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'What-a Chat',
      home: chatFrame(),
    );
  }
}

// ignore: camel_case_types
class chatFrame extends StatelessWidget {
  const chatFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('What-a Chat')),
      body: const AnaEkran(),
    );
  }
}

class AnaEkran extends StatefulWidget {
  const AnaEkran({super.key});

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  TextEditingController c1 = TextEditingController();

  List<MesajBalonu> mesajlar = [];

  mesajEkle(var gelenMesaj) {
    setState(() {
      MesajBalonu mesajNesnesi = MesajBalonu(
        mesaj: gelenMesaj,
      );
      mesajlar.insert(0, mesajNesnesi);
      c1.clear();
    });
  }

  Widget metinGirisAlani() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: c1,
            ),
          ),
          IconButton(
            onPressed: () => mesajEkle(c1.text),
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
                reverse: true,
                itemCount: mesajlar.length,
                itemBuilder: (_, int indexNumber) => mesajlar[indexNumber]),
          ),

          metinGirisAlani(),
          // Row(
          //   children: [
          //     Flexible(
          //       child: TextField(
          //         onSubmitted: mesajEkle,
          //         controller: c1,
          //       ),
          //     ),
          //     ElevatedButton(
          //       onPressed: () => mesajEkle(c1.text),
          //       child: const Text('Gönder'),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

var isim = 'kullanıcı1';

// ignore: must_be_immutable
class MesajBalonu extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var mesaj;

  MesajBalonu({super.key, this.mesaj});
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            child: Text(isim[0]),
          ),
          Column(
            children: [
              Text(isim),
              Text(mesaj),
            ],
          )
        ],
      ),
    );
  }
}

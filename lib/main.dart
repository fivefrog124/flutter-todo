// // ignore_for_file: prefer_typing_uninitialized_variables, avoid_print
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'ToDo Uygulaması',
//       home: Iskele(),
//     );
//   }
// }

// class Iskele extends StatelessWidget {
//   const Iskele({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Yapılacaklar Listesi'),
//       ),
//       body: const AnaEkran(),
//     );
//   }
// }

// class AnaEkran extends StatefulWidget {
//   const AnaEkran({super.key});

//   @override
//   State<AnaEkran> createState() => _AnaEkranState();
// }

// class _AnaEkranState extends State<AnaEkran> {
//   TextEditingController t1 = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     t1.dispose();

//     super.dispose();
//   }

//   List<Todo> yapilacaklarListesi = [];

//   bool isDisabled = true;

//   elemanEkle() {
//     acition_api(t1.text);
//     t1.clear();

//     textFieldOnKeyUp(t1.text);
//     setState(() {});
//   }

// //ignore: non_constant_identifier_names
//   acition_api(String param) async {
//     var url =
//         Uri.parse('http://192.168.1.6/todo_flutter/todo_action.php?t1=$param');
//     var response = await http.get(url);

//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     setState(() {});
//   }

//   // ignore: non_constant_identifier_names
//   Future<List<Todo>> get_api() async {
//     var url = Uri.parse('http://192.168.1.6/todo_flutter/todo_get.php');
//     var response = await http.get(url);

//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     var datas = jsonDecode(response.body);

//     for (var u in datas) {
//       Todo todo = Todo(u["id"], u["myTodo"]);

//       yapilacaklarListesi.add(todo);
//     }

//     print(yapilacaklarListesi.length);

//     return yapilacaklarListesi;
//   }

//   // ignore: non_constant_identifier_names
//   delete_api(id) async {
//     var url =
//         Uri.parse('http://192.168.1.6/todo_flutter/todo_delete.php?id=$id');
//     var response = await http.get(url);

//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');
//     setState(() {});
//   }

//   textFieldOnKeyUp(String text) {
//     int count = text.length;

//     // ignore: unrelated_type_equality_checks
//     if (count == 0) {
//       isDisabled = true;
//     } else {
//       isDisabled = false;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: avoid_unnecessary_containers
//     return Scaffold(
//       // ignore: avoid_unnecessary_containers
//       body: Container(
//         child: FutureBuilder(
//           future: get_api(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             print(snapshot.data);
//             if (snapshot.hasData) {
//               return GestureDetector(
//                 onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//                 behavior: HitTestBehavior.translucent,
//                 child: Scaffold(
//                   body: Column(
//                     children: [
//                       Flexible(
//                         child: ListView.builder(
//                           itemCount: snapshot.data.length,
//                           itemBuilder: (context, index) {
//                             return Dismissible(
//                               // ignore: avoid_unnecessary_containers
//                               background: Container(
//                                 color: Colors.green,
//                                 child: Row(
//                                   children: [
//                                     // ignore: avoid_unnecessary_containers
//                                     Container(
//                                       margin: const EdgeInsets.all(5.0),
//                                       child: const Icon(
//                                           Icons.assistant_photo_sharp,
//                                           color: Colors.white),
//                                     ),
//                                     const Text('Yapılacakların Tamamlandı',
//                                         style: TextStyle(color: Colors.white)),
//                                   ],
//                                 ),
//                               ),
//                               key: ValueKey(yapilacaklarListesi[index]),
//                               confirmDismiss:
//                                   (DismissDirection direction) async {
//                                 showDialog(
//                                   barrierDismissible: false,
//                                   context: context,
//                                   builder: (BuildContext context) =>
//                                       AlertDialog(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20.0),
//                                     ),
//                                     title: const Text(
//                                         'Silmek İstediğinize Emin Misiniz?'),
//                                     content: const Text(
//                                         'Sildiğiniz hatırlatmalar tamamen kaybolur'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context, 'İptal');
//                                         },
//                                         child: const Text('İptal'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           setState(() {
//                                             Navigator.pop(context, 'Sil');
//                                             delete_api(
//                                                 yapilacaklarListesi[index]);
//                                             yapilacaklarListesi.removeAt(index);
//                                           });
//                                         },
//                                         child: const Text('Sil'),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                                 return null;
//                               },
//                               child: ListTile(
//                                 subtitle: const Text('Yapılacaklar'),
//                                 title:
//                                     Text(yapilacaklarListesi[index] as String),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       // ignore: avoid_unnecessary_containers
//                       Container(
//                         margin: const EdgeInsets.all(28),
//                         alignment: Alignment.bottomRight,
//                         child: FloatingActionButton(
//                           onPressed: () => displayDialog(),
//                           tooltip: 'Add Item',
//                           child: const Icon(Icons.add),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               // ignore: avoid_unnecessary_containers
//               return Container(
//                 child: const Center(
//                   child: Text("Loading..."),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   displayDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20.0),
//           ),
//           title: const Text('Yapacaklarını Listeye Ekle'),
//           content: TextField(
//             controller: t1,
//             decoration: const InputDecoration(
//                 hintText: 'Yeni yapılacaklar listeni yaz'),
//             onChanged: (index) {
//               textFieldOnKeyUp(t1.text);

//               setState(() {});
//             },
//           ),
//           actions: [
//             // ignore: avoid_unnecessary_containers
//             Container(
//               child: Stack(
//                 children: [
//                   Center(
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                         ),
//                       ),
//                       onPressed: () {
//                         isDisabled ? null : elemanEkle();
//                       },
//                       child: const Text('Ekle'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class Todo {
//   final int id;
//   final String myTodo;

//   Todo(this.id, this.myTodo);
// }

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ToDo Uygulaması',
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  const Iskele({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: null,
      body: CountdownTimer(),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countdownTimer;

  Duration myDuration = const Duration(minutes: 10);
  @override
  void initState() {
    super.initState();

    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(1));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              RichText(
                text: TextSpan(
                  text: '$minutes' ' ' '$seconds',
                  style: const TextStyle(
                      letterSpacing: 70.0,
                      fontFamily: 'Bebas Neue',
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 200),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'countdown.dart';
import 'countup.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
      body: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_background.png"),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 82, vertical: 5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountdownTimer(
                          countMin: 15,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '15 MIN',
                    style: TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 60),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 82, vertical: 5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountdownTimer(
                          countMin: 25,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '25 MIN',
                    style: TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 60),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 82, vertical: 5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountdownTimer(
                          countMin: 40,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '40 MIN',
                    style: TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 60),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 82, vertical: 5),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CountdownTimer1(),
                      ),
                    );
                  },
                  child: const Text(
                    'INFINTI',
                    style: TextStyle(
                        fontFamily: 'Bebas Neue',
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 60),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const AttendanceScreen(),
//     );
//   }
// }

// class AttendanceScreen extends StatefulWidget {
//   const AttendanceScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   static var countdownDuration = const Duration(minutes: 10);
//   static var countdownDuration1 = const Duration(minutes: 10);
//   Duration duration = const Duration();
//   Duration duration1 = const Duration();
//   Timer? timer;
//   Timer? timer1;
//   bool countDown = true;
//   bool countDown1 = true;

//   @override
//   void initState() {
//     var hours;
//     var mints;
//     var secs;
//     hours = int.parse("00");
//     mints = int.parse("00");
//     secs = int.parse("00");
//     countdownDuration = Duration(hours: hours, minutes: mints, seconds: secs);
//     startTimer();
//     reset();
//     var hours1;
//     var mints1;
//     var secs1;
//     hours1 = int.parse("10");
//     mints1 = int.parse("00");
//     secs1 = int.parse("00");
//     countdownDuration1 =
//         Duration(hours: hours1, minutes: mints1, seconds: secs1);
//     startTimer1();
//     reset1();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Timer Example"),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             color: Colors.white,
//             onPressed: () {
//               _onWillPop();
//             },
//           ),
//         ),
//         body: Container(
//           color: Colors.black12,
//           width: double.infinity,
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   "Timer",
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 Container(
//                     margin: const EdgeInsets.only(top: 30, bottom: 30),
//                     child: buildTime()),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   "Count down timer",
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 Container(
//                     margin: const EdgeInsets.only(top: 30, bottom: 30),
//                     child: buildTime1()),
//               ]),
//         ),
//       ),
//     );
//   }

//   Future<bool> _onWillPop() async {
//     final isRunning = timer == null ? false : timer!.isActive;
//     if (isRunning) {
//       timer!.cancel();
//     }
//     Navigator.of(context, rootNavigator: true).pop(context);
//     return true;
//   }

//   void reset() {
//     if (countDown) {
//       setState(() => duration = countdownDuration);
//     } else {
//       setState(() => duration = const Duration());
//     }
//   }

//   void reset1() {
//     if (countDown) {
//       setState(() => duration1 = countdownDuration1);
//     } else {
//       setState(() => duration1 = const Duration());
//     }
//   }

//   void startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
//   }

//   void startTimer1() {
//     timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime1());
//   }

//   void addTime() {
//     final addSeconds = 1;
//     setState(() {
//       final seconds = duration.inSeconds + addSeconds;
//       if (seconds < 0) {
//         timer?.cancel();
//       } else {
//         duration = Duration(seconds: seconds);
//       }
//     });
//   }

//   void addTime1() {
//     final addSeconds = 1;
//     setState(() {
//       final seconds = duration1.inSeconds - addSeconds;
//       if (seconds < 0) {
//         timer1?.cancel();
//       } else {
//         duration1 = Duration(seconds: seconds);
//       }
//     });
//   }

//   Widget buildTime() {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       buildTimeCard(time: hours, header: 'HOURS'),
//       const SizedBox(
//         width: 8,
//       ),
//       buildTimeCard(time: minutes, header: 'MINUTES'),
//       const SizedBox(
//         width: 8,
//       ),
//       buildTimeCard(time: seconds, header: 'SECONDS'),
//     ]);
//   }

//   Widget buildTime1() {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration1.inHours);
//     final minutes = twoDigits(duration1.inMinutes.remainder(60));
//     final seconds = twoDigits(duration1.inSeconds.remainder(60));
//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//       buildTimeCard(time: hours, header: 'HOURS'),
//       const SizedBox(
//         width: 8,
//       ),
//       buildTimeCard(time: minutes, header: 'MINUTES'),
//       const SizedBox(
//         width: 8,
//       ),
//       buildTimeCard(time: seconds, header: 'SECONDS'),
//     ]);
//   }

//   Widget buildTimeCard({required String time, required String header}) =>
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(20)),
//             child: Text(
//               time,
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 50),
//             ),
//           ),
//           const SizedBox(
//             height: 24,
//           ),
//           Text(header, style: const TextStyle(color: Colors.black45)),
//         ],
//       );
// }

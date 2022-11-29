// // ignore: file_names
// import 'package:flutter/material.dart';
// import 'anaEkran.dart';
// void main() {
//   runApp(MyApp());

//   var isim = 'Ali';
//   print(isim);

//   ekranaYazdir() {
//     print('merhaba');
//   }

//   ekranaYazdir();
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'İlkel Blog Uygulaması',
//       home: AnaEkran(),
//     );
//   }
// }

// class AnaEkran extends StatelessWidget {
//   const AnaEkran({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blog Uygulaması'),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(35),
//         child: Center(
//           child: Text('Merhaba'),
//         ),
//       ),
//     );
//   }
// }

// -----------------------------------------------------------------------

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'İlkel Blog Uygulaması',
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
//         title: Text('Blog Uygulaması'),
//       ),
//       body: Iskele(),
//     );
//   }
// }

// class AnaEkran extends StatefulWidget {
//   const AnaEkran({super.key});

//   @override
//   State<AnaEkran> createState() => _AnaEkranState();
// }

// class _AnaEkranState extends State<AnaEkran> {
//   var blogYazisi = 'Bloga Hoşgeldiniz';

//   martGoster() {
//     setState(() {
//       blogYazisi = 'hebele hübele mart';
//     });
//   }

//   nisanGoster() {
//     setState(() {
//       blogYazisi = 'hebele hübele nisan';
//     });
//   }

//   mayisGoster() {
//     setState(() {
//       blogYazisi = 'hebele hübele mayıs';
//     });
//   }

//   haziranGoster() {
//     setState(() {
//       blogYazisi = 'hebele hübele haziran';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(blogYazisi),
//             ElevatedButton(
//               onPressed: martGoster,
//               child: Text('Mart Yazısı'),
//             ),
//             ElevatedButton(
//               onPressed: nisanGoster,
//               child: Text('Nisan Yazısı'),
//             ),
//             ElevatedButton(
//               onPressed: mayisGoster,
//               child: Text('Mayıs Yazısı'),
//             ),
//             ElevatedButton(
//               onPressed: haziranGoster,
//               child: Text('Haziran Yazısı'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// -----------------------------------------------------------------------

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Hesap Makinesi',
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
//         title: const Text('Basit Hesap Makinesi'),
//       ),
//       body: const AnaEkran(),
//     );
//   }
// }

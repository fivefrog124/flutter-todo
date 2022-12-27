import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

// ignore: must_be_immutable
class SettingsPage extends StatefulWidget {
  int themeValue = 0;
  SettingsPage({super.key, required this.themeValue});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // ignore: prefer_typing_uninitialized_variables
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.themeValue == 1
                ? const AssetImage(
                    "assets/images/background1_global_warming.png")
                : widget.themeValue == 2
                    ? const AssetImage(
                        "assets/images/background1_abstract_truths.png")
                    : widget.themeValue == 3
                        ? const AssetImage(
                            "assets/images/background1_sahara_desert.png")
                        : widget.themeValue == 4
                            ? const AssetImage(
                                "assets/images/background1_abysmal_aqua.png")
                            : widget.themeValue == 5
                                ? const AssetImage(
                                    "assets/images/background1_1.png")
                                : widget.themeValue == 6
                                    ? const AssetImage(
                                        "assets/images/background1_2.png")
                                    : const AssetImage(
                                        "assets/images/background1_mor.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 56, top: 60),
                        child: widget.themeValue == 1
                            ? Text(
                                'THEMES',
                                style: GoogleFonts.redHatDisplay(
                                  fontSize: 60,
                                  color: Colors.white,
                                ),
                              )
                            : widget.themeValue == 2
                                ? Text(
                                    'THEMES',
                                    style: GoogleFonts.workSans(
                                      letterSpacing: -3,
                                      fontSize: 60,
                                      color: Colors.white,
                                    ),
                                  )
                                : widget.themeValue == 3
                                    ? Text(
                                        'THEMES',
                                        style: GoogleFonts.barlowSemiCondensed(
                                          fontSize: 60,
                                          color: Colors.white,
                                        ),
                                      )
                                    : widget.themeValue == 4
                                        ? Text(
                                            'THEMES',
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 60,
                                              color: Colors.white,
                                            ),
                                          )
                                        : widget.themeValue == 5
                                            ? Text(
                                                'THEMES',
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                  fontSize: 60,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : widget.themeValue == 6
                                                ? Text(
                                                    'THEMES',
                                                    style: GoogleFonts.urbanist(
                                                      fontSize: 60,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Text(
                                                    'THEMES',
                                                    style:
                                                        GoogleFonts.bebasNeue(
                                                      fontSize: 60,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.themeValue = 1;
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnaSayfa(
                                      themeValue: 1,
                                    ),
                                  ),
                                ).then(
                                  (value) => Navigator.of(context).pop(),
                                );
                              });
                              return;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 14.0),
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/theme_global_warming.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Global\nWarming",
                                  style: GoogleFonts.redHatDisplay(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.themeValue = 2;

                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnaSayfa(
                                      themeValue: 2,
                                    ),
                                  ),
                                ).then(
                                  (value) => Navigator.of(context).pop(),
                                );
                              });
                              return;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 14.0),
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/theme_abstract_truths.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Abstract\nTruths',
                                  style: GoogleFonts.workSans(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.themeValue = 3;

                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnaSayfa(
                                      themeValue: 3,
                                    ),
                                  ),
                                ).then(
                                  (value) => Navigator.of(context).pop(),
                                );
                              });
                              return;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 14.0),
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/theme_sahara_dersert.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Wet\nDesert',
                                  style: GoogleFonts.barlowCondensed(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.themeValue = 4;
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnaSayfa(
                                      themeValue: 4,
                                    ),
                                  ),
                                ).then(
                                  (value) => Navigator.of(context).pop(),
                                );
                              });
                              return;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 14.0),
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/theme_abysmal_aqua.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Abysmal\nAqua',
                                  style: GoogleFonts.ubuntu(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.themeValue = 5;
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnaSayfa(
                                      themeValue: 5,
                                    ),
                                  ),
                                ).then(
                                  (value) => Navigator.of(context).pop(),
                                );
                              });
                              return;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 14.0),
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/theme_1.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Atmospheric\nPressure',
                                  style: GoogleFonts.sourceSansPro(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.themeValue = 6;
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AnaSayfa(
                                      themeValue: 6,
                                    ),
                                  ),
                                ).then(
                                  (value) => Navigator.of(context).pop(),
                                );
                              });
                              return;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 14.0),
                              width: 160,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                                image: const DecorationImage(
                                  image:
                                      AssetImage("assets/images/theme_2.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Unexpected\nErection',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 28.0),
                      child: GestureDetector(
                        onTap: () {
                          widget.themeValue = 0;
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnaSayfa(
                                  themeValue: 0,
                                ),
                              ),
                            ).then(
                              (value) => Navigator.of(context).pop(),
                            );
                          });
                          return;
                        },
                        child: Container(
                          width: 160,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/theme_mor.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Mor',
                              style: GoogleFonts.bebasNeue(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'countdown.dart';
import 'countup.dart';
import 'settingsPage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: Iskele(),
    );
  }
}

class Iskele extends StatelessWidget {
  const Iskele({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: AnaSayfa(themeValue: 0),
    );
  }
}

// ignore: must_be_immutable
class AnaSayfa extends StatefulWidget {
  int themeValue = 0;
  AnaSayfa({super.key, required this.themeValue});

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
    return Stack(
      children: [
        Container(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 290,
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      backgroundColor: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountdownTimer(
                            countMin: 5,
                            themeValue: widget.themeValue,
                          ),
                        ),
                      );
                    },
                    child: widget.themeValue == 1
                        ? Text(
                            '15 MIN',
                            style: GoogleFonts.redHatDisplay(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          )
                        : widget.themeValue == 2
                            ? Text(
                                '15 MIN',
                                style: GoogleFonts.workSans(
                                  fontSize: 55,
                                  color: Colors.white,
                                ),
                              )
                            : widget.themeValue == 3
                                ? Text(
                                    '15 MIN',
                                    style: GoogleFonts.montserrat(
                                      letterSpacing: -3,
                                      fontSize: 50,
                                      color: Colors.white,
                                    ),
                                  )
                                : widget.themeValue == 4
                                    ? Text(
                                        '15 MIN',
                                        style: GoogleFonts.ubuntu(
                                          letterSpacing: -3,
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                      )
                                    : widget.themeValue == 5
                                        ? Text(
                                            '15 MIN',
                                            style: GoogleFonts.sourceSansPro(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 55,
                                              letterSpacing: -3,
                                              color: Colors.white,
                                            ),
                                          )
                                        : widget.themeValue == 6
                                            ? Text(
                                                '15 MIN',
                                                style: GoogleFonts.urbanist(
                                                  fontSize: 55,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                '15 MIN',
                                                style: GoogleFonts.bebasNeue(
                                                  fontSize: 60,
                                                  color: Colors.white,
                                                ),
                                              ),
                  ),
                ),
                Container(
                  width: 290,
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      backgroundColor: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountdownTimer(
                            countMin: 25,
                            themeValue: widget.themeValue,
                          ),
                        ),
                      );
                    },
                    child: widget.themeValue == 1
                        ? Text(
                            '15 MIN',
                            style: GoogleFonts.redHatDisplay(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          )
                        : widget.themeValue == 2
                            ? Text(
                                '25 MIN',
                                style: GoogleFonts.workSans(
                                  fontSize: 55,
                                  color: Colors.white,
                                ),
                              )
                            : widget.themeValue == 3
                                ? Text(
                                    '25 MIN',
                                    style: GoogleFonts.montserrat(
                                      letterSpacing: -3,
                                      fontSize: 50,
                                      color: Colors.white,
                                    ),
                                  )
                                : widget.themeValue == 4
                                    ? Text(
                                        '25 MIN',
                                        style: GoogleFonts.ubuntu(
                                          letterSpacing: -3,
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                      )
                                    : widget.themeValue == 5
                                        ? Text(
                                            '25 MIN',
                                            style: GoogleFonts.sourceSansPro(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 55,
                                              letterSpacing: -3,
                                              color: Colors.white,
                                            ),
                                          )
                                        : widget.themeValue == 6
                                            ? Text(
                                                '25 MIN',
                                                style: GoogleFonts.urbanist(
                                                  fontSize: 55,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                '25 MIN',
                                                style: GoogleFonts.bebasNeue(
                                                  fontSize: 60,
                                                  color: Colors.white,
                                                ),
                                              ),
                  ),
                ),
                Container(
                  width: 290,
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      backgroundColor: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountdownTimer(
                            countMin: 40,
                            themeValue: widget.themeValue,
                          ),
                        ),
                      );
                    },
                    child: widget.themeValue == 1
                        ? Text(
                            '40 MIN',
                            style: GoogleFonts.redHatDisplay(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          )
                        : widget.themeValue == 2
                            ? Text(
                                '40 MIN',
                                style: GoogleFonts.workSans(
                                  fontSize: 55,
                                  color: Colors.white,
                                ),
                              )
                            : widget.themeValue == 3
                                ? Text(
                                    '40 MIN',
                                    style: GoogleFonts.montserrat(
                                      letterSpacing: -3,
                                      fontSize: 50,
                                      color: Colors.white,
                                    ),
                                  )
                                : widget.themeValue == 4
                                    ? Text(
                                        '40 MIN',
                                        style: GoogleFonts.ubuntu(
                                          letterSpacing: -3,
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                      )
                                    : widget.themeValue == 5
                                        ? Text(
                                            '40 MIN',
                                            style: GoogleFonts.sourceSansPro(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 55,
                                              letterSpacing: -3,
                                              color: Colors.white,
                                            ),
                                          )
                                        : widget.themeValue == 6
                                            ? Text(
                                                '40 MIN',
                                                style: GoogleFonts.urbanist(
                                                  fontSize: 55,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                '40 MIN',
                                                style: GoogleFonts.bebasNeue(
                                                  fontSize: 60,
                                                  color: Colors.white,
                                                ),
                                              ),
                  ),
                ),
                Container(
                  width: 290,
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                      backgroundColor: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountdownTimer1(
                            themeValue: widget.themeValue,
                          ),
                        ),
                      );
                    },
                    child: widget.themeValue == 1
                        ? Text(
                            'INFINITI',
                            style: GoogleFonts.redHatDisplay(
                              fontSize: 50,
                              color: Colors.white,
                            ),
                          )
                        : widget.themeValue == 2
                            ? Text(
                                'INFINITI',
                                style: GoogleFonts.workSans(
                                  fontSize: 55,
                                  color: Colors.white,
                                ),
                              )
                            : widget.themeValue == 3
                                ? Text(
                                    'INFINITI',
                                    style: GoogleFonts.montserrat(
                                      letterSpacing: -3,
                                      fontSize: 50,
                                      color: Colors.white,
                                    ),
                                  )
                                : widget.themeValue == 4
                                    ? Text(
                                        'INFINITI',
                                        style: GoogleFonts.ubuntu(
                                          letterSpacing: -3,
                                          fontSize: 50,
                                          color: Colors.white,
                                        ),
                                      )
                                    : widget.themeValue == 5
                                        ? Text(
                                            'INFINITI',
                                            style: GoogleFonts.sourceSansPro(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 55,
                                              letterSpacing: -3,
                                              color: Colors.white,
                                            ),
                                          )
                                        : widget.themeValue == 6
                                            ? Text(
                                                'INFINITI',
                                                style: GoogleFonts.urbanist(
                                                  fontSize: 55,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(
                                                'INFINITI',
                                                style: GoogleFonts.bebasNeue(
                                                  fontSize: 60,
                                                  color: Colors.white,
                                                ),
                                              ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    themeValue: widget.themeValue,
                  ),
                ),
              );
            },
            child: Container(
                width: 65,
                height: 65,
                margin: const EdgeInsets.only(top: 40, right: 34),
                padding: const EdgeInsets.all(18.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white10,
                ),
                child: Image.asset(
                  'assets/images/settings1.png',
                )),
          ),
        )
      ],
    );
  }
}

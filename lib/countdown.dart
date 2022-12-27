import 'dart:async';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class CountdownTimer extends StatefulWidget {
  int countMin;
  int themeValue;

  CountdownTimer({super.key, required this.countMin, required this.themeValue});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  Timer? countdownTimer;
  Timer? countdownTimer2;

  late int countMin;

  late Duration myDuration;
  bool cursorVisible = true;
  bool startStop = true;
  bool audioStart = false;
  bool lottieStart = true;
  bool visibleBar = false;
  bool isCircle = false;
  final audio = AudioPlayer();
  final backgroundAudio = AssetsAudioPlayer();
  final ambientAudio = AssetsAudioPlayer();

  AnimationController? _animationController;

  int _value = 0;
  double volume = 50.0;
  double _width = 36.0;

  int achievementStep15 = 0;

  @override
  initState() async {
    super.initState();
    var achievement_db = await openDatabase('achievement_db.db');

    await achievement_db.execute(
        'CREATE TABLE achievement (id INTEGER PRIMARY KEY, achievement15 INTEGER, achievement25 INTEGER, achievement40 INTEGER, achievementINFINITI INTEGER)');

    // ignore: await_only_futures
    myDuration = Duration(seconds: widget.countMin);

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});

      setCountDown();
    });

    countdownTimer2 = Timer.periodic(const Duration(seconds: 1), (_) {
      cursorVisible ? cursorVisible = false : cursorVisible = true;
      setState(() {});
      setCountDown2();
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    achievementFunc();
    backgroundAudio.open(
        Audio.network('http://pavo.prostreaming.net:8052/stream'),
        loopMode: LoopMode.playlist);

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animationController?.value = 0.1;
  }

  @override
  dispose() {
    countdownTimer!.cancel();
    countdownTimer2!.cancel();

    backgroundAudio.pause();
    ambientAudio.pause();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  achievementFunc() async {
    if (achievementStep15 == 1) {
      showAchievement15(context);
    }
  }

  void showAchievement15(BuildContext context) {
    AchievementView(context,
        title: "Yeaaah!",
        subTitle: "Successfully completed 15 minutes of study!",
        icon: const Icon(
          Icons.stars_rounded,
          color: Colors.white,
        ),
        typeAnimationContent: AnimationTypeAchievement.fadeSlideToUp,
        color: Colors.green,
        textStyleTitle: const TextStyle(),
        textStyleSubTitle: const TextStyle(),
        alignment: Alignment.topCenter,
        duration: const Duration(seconds: 4),
        isCircle: true, listener: (status) {
      // ignore: avoid_print
      print(status);
      AchievementState.opening;
      AchievementState.open;
      AchievementState.closing;
      AchievementState.closed;
    }).show();
  }

  startOrStop() {
    if (startStop) {
      // ignore: avoid_print
      print("startstop Inside=$startStop");
      stopTimer();
    } else {
      startTimer();
    }
  }

  startTimer() {
    setState(() {
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        setCountDown();
      });
      startStop = true;
    });
  }

  stopTimer() {
    setState(() {
      startStop = false;
      countdownTimer!.cancel();
    });
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        if (widget.countMin == 5) {
          achievementStep15++;
          // ignore: avoid_print
          print(achievementStep15);
          achievementFunc();
        }
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void setCountDown2() {
    const reduceSecondsBy = 1;
    setState(() {
      // ignore: unused_local_variable
      final seconds = myDuration.inSeconds + reduceSecondsBy;
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0)),
            title: const Text(
              'Stop The Timer',
              style: TextStyle(
                fontSize: 36,
                fontFamily: 'Bebas Neue',
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Are you sure you want to stop the timer?',
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontSize: 20,
                      fontFamily: 'Bebas Neue',
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Nope',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    fontFamily: 'Bebas Neue',
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'Yep, stop',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontFamily: 'Bebas Neue',
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  countdownTimer!.cancel();
                  countdownTimer2!.cancel();

                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                },
              ),
            ],
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        countdownTimer!.cancel();
        countdownTimer2!.cancel();
        // ignore: avoid_print
        print("geriye çıkıldı canım!");
        return true;
      },
      child: Scaffold(
        appBar: null,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.themeValue == 1
                      ? const AssetImage(
                          "assets/images/background2_global_warming.png")
                      : widget.themeValue == 2
                          ? const AssetImage(
                              "assets/images/background2_abstract_truths.png")
                          : widget.themeValue == 3
                              ? const AssetImage(
                                  "assets/images/background2_sahara_desert.png")
                              : widget.themeValue == 4
                                  ? const AssetImage(
                                      "assets/images/background2_abysmal_aqua.png")
                                  : widget.themeValue == 5
                                      ? const AssetImage(
                                          "assets/images/background2_1.png")
                                      : widget.themeValue == 6
                                          ? const AssetImage(
                                              "assets/images/background2_2.png")
                                          : const AssetImage(
                                              "assets/images/background2_mor.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          width: 140,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(18, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : cursorVisible
                                    ? null
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            150, 196, 68, 68),
                                        width: 3,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            minutes[0],
                            style: widget.themeValue == 1
                                ? GoogleFonts.redHatDisplay(
                                    fontSize: 160,
                                    color: Colors.white,
                                    letterSpacing: 60.0,
                                    fontWeight: FontWeight.normal,
                                  )
                                : widget.themeValue == 2
                                    ? GoogleFonts.workSans(
                                        fontSize: 160,
                                        color: Colors.white,
                                        letterSpacing: 60.0,
                                        fontWeight: FontWeight.normal,
                                      )
                                    : widget.themeValue == 3
                                        ? GoogleFonts.montserrat(
                                            fontSize: 150,
                                            color: Colors.white,
                                            letterSpacing: 60.0,
                                            fontWeight: FontWeight.w500,
                                          )
                                        : widget.themeValue == 4
                                            ? GoogleFonts.ubuntu(
                                                fontSize: 160,
                                                color: Colors.white,
                                                letterSpacing: 60.0,
                                                fontWeight: FontWeight.normal,
                                              )
                                            : widget.themeValue == 5
                                                ? GoogleFonts.sourceSansPro(
                                                    fontSize: 160,
                                                    color: Colors.white,
                                                    letterSpacing: 60.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )
                                                : widget.themeValue == 6
                                                    ? GoogleFonts.urbanist(
                                                        fontSize: 160,
                                                        color: Colors.white,
                                                        letterSpacing: 60.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )
                                                    : GoogleFonts.bebasNeue(
                                                        fontSize: 160,
                                                        color: Colors.white,
                                                        letterSpacing: 60.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          width: 140,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(18, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : cursorVisible
                                    ? null
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            150, 196, 68, 68),
                                        width: 3,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            minutes[1],
                            style: widget.themeValue == 1
                                ? GoogleFonts.redHatDisplay(
                                    fontSize: 160,
                                    color: Colors.white,
                                    letterSpacing: 60.0,
                                    fontWeight: FontWeight.normal,
                                  )
                                : widget.themeValue == 2
                                    ? GoogleFonts.workSans(
                                        fontSize: 160,
                                        color: Colors.white,
                                        letterSpacing: 60.0,
                                        fontWeight: FontWeight.normal,
                                      )
                                    : widget.themeValue == 3
                                        ? GoogleFonts.montserrat(
                                            fontSize: 150,
                                            color: Colors.white,
                                            letterSpacing: 60.0,
                                            fontWeight: FontWeight.w500,
                                          )
                                        : widget.themeValue == 4
                                            ? GoogleFonts.ubuntu(
                                                fontSize: 160,
                                                color: Colors.white,
                                                letterSpacing: 60.0,
                                                fontWeight: FontWeight.normal,
                                              )
                                            : widget.themeValue == 5
                                                ? GoogleFonts.sourceSansPro(
                                                    fontSize: 160,
                                                    color: Colors.white,
                                                    letterSpacing: 60.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )
                                                : widget.themeValue == 6
                                                    ? GoogleFonts.urbanist(
                                                        fontSize: 160,
                                                        color: Colors.white,
                                                        letterSpacing: 60.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )
                                                    : GoogleFonts.bebasNeue(
                                                        fontSize: 160,
                                                        color: Colors.white,
                                                        letterSpacing: 60.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Opacity(
                          opacity: cursorVisible ? 1 : 0.5,
                          child: const Text(
                            ':',
                            style: TextStyle(
                              letterSpacing: 10.0,
                              color: Colors.white,
                              fontSize: 160,
                              fontFamily: 'Bebas Neue',
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          width: 140,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(18, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : cursorVisible
                                    ? null
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            150, 196, 68, 68),
                                        width: 3,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            seconds[0],
                            style: widget.themeValue == 1
                                ? GoogleFonts.redHatDisplay(
                                    fontSize: 160,
                                    color: Colors.white,
                                    letterSpacing: 60.0,
                                    fontWeight: FontWeight.normal,
                                  )
                                : widget.themeValue == 2
                                    ? GoogleFonts.workSans(
                                        fontSize: 160,
                                        color: Colors.white,
                                        letterSpacing: 60.0,
                                        fontWeight: FontWeight.normal,
                                      )
                                    : widget.themeValue == 3
                                        ? GoogleFonts.montserrat(
                                            fontSize: 150,
                                            color: Colors.white,
                                            letterSpacing: 60.0,
                                            fontWeight: FontWeight.w500,
                                          )
                                        : widget.themeValue == 4
                                            ? GoogleFonts.ubuntu(
                                                fontSize: 160,
                                                color: Colors.white,
                                                letterSpacing: 60.0,
                                                fontWeight: FontWeight.normal,
                                              )
                                            : widget.themeValue == 5
                                                ? GoogleFonts.sourceSansPro(
                                                    fontSize: 160,
                                                    color: Colors.white,
                                                    letterSpacing: 60.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )
                                                : widget.themeValue == 6
                                                    ? GoogleFonts.urbanist(
                                                        fontSize: 160,
                                                        color: Colors.white,
                                                        letterSpacing: 60.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )
                                                    : GoogleFonts.bebasNeue(
                                                        fontSize: 160,
                                                        color: Colors.white,
                                                        letterSpacing: 60.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          width: 140,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(18, 255, 255, 255),
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : cursorVisible
                                    ? null
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            150, 196, 68, 68),
                                        width: 3,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            seconds[1],
                            style: widget.themeValue == 1
                                ? GoogleFonts.redHatDisplay(
                                    fontSize: 160,
                                    color: Colors.white,
                                    letterSpacing: 60.0,
                                    fontWeight: FontWeight.normal,
                                  )
                                : widget.themeValue == 2
                                    ? GoogleFonts.workSans(
                                        fontSize: 160,
                                        color: Colors.white,
                                        letterSpacing: 60.0,
                                        fontWeight: FontWeight.normal,
                                      )
                                    : widget.themeValue == 3
                                        ? GoogleFonts.montserrat(
                                            fontSize: 150,
                                            color: Colors.white,
                                            letterSpacing: 60.0,
                                            fontWeight: FontWeight.w500,
                                          )
                                        : widget.themeValue == 4
                                            ? GoogleFonts.ubuntu(
                                                fontSize: 160,
                                                color: Colors.white,
                                                letterSpacing: 60.0,
                                                fontWeight: FontWeight.normal,
                                              )
                                            : widget.themeValue == 5
                                                ? GoogleFonts.sourceSansPro(
                                                    fontSize: 160,
                                                    color: Colors.white,
                                                    letterSpacing: 60.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  )
                                                : widget.themeValue == 6
                                                    ? GoogleFonts.urbanist(
                                                        fontSize: 160,
                                                        color: Colors.white,
                                                        letterSpacing: 60.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )
                                                    : GoogleFonts.bebasNeue(
                                                        fontSize: 160,
                                                        color: Colors.white,
                                                        letterSpacing: 60.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    showMyDialog();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 55, bottom: 18),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: widget.themeValue == 1
                      ? BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12))
                      : widget.themeValue == 2
                          ? BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12))
                          : widget.themeValue == 3
                              ? BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(12))
                              : widget.themeValue == 4
                                  ? BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(12))
                                  : widget.themeValue == 5
                                      ? BoxDecoration(
                                          color: Colors.white30,
                                          borderRadius:
                                              BorderRadius.circular(12))
                                      : widget.themeValue == 6
                                          ? BoxDecoration(
                                              color: Colors.white10,
                                              borderRadius:
                                                  BorderRadius.circular(12))
                                          : BoxDecoration(
                                              color: Colors.white10,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                  child: IconButton(
                      color: Colors.white,
                      iconSize: 42.0,
                      onPressed: () {
                        startOrStop();
                      },
                      icon: startStop
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow)),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (lottieStart) {
                  lottieStart = false;
                  _animationController?.animateTo(0.33);

                  backgroundAudio.pause();

                  // ignore: avoid_print
                  print("ileri");
                } else {
                  _animationController?.reverse();
                  backgroundAudio.play();
                  lottieStart = true;
                  // ignore: avoid_print
                  print("reverse");
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  margin: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12)),
                  child: Lottie.asset(
                    'assets/animations/Main.json',
                    controller: _animationController,
                    height: 48,
                    repeat: false,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                left: 8,
                                right: 8,
                              ),
                              padding: const EdgeInsets.all(12.0),
                              decoration: _width > 52
                                  ? BoxDecoration(
                                      color:
                                          _value == 1 ? Colors.white24 : null,
                                      border: _value == 1
                                          ? Border.all(color: Colors.white)
                                          : null,
                                      borderRadius: BorderRadius.circular(8.0),
                                    )
                                  : BoxDecoration(
                                      color:
                                          _value == 1 ? Colors.white24 : null,
                                      border: _value == 1
                                          ? Border.all(color: Colors.white)
                                          : null,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                    ),
                              height: 56,
                              width: _width < 56 && _width >= 0 ? _width : 56,
                              child: const SizedBox(),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_value == 1) {
                                    ambientAudio.pause();
                                    _value = 0;
                                  } else {
                                    _value = 1;
                                  }
                                });
                                if (_value != 0) {
                                  ambientAudio.open(
                                      Audio('assets/audios/forest.mp3'),
                                      loopMode: LoopMode.playlist);
                                }
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  ambientAudio
                                      .setVolume(volume / 100.toDouble());
                                  if (details.delta.dx > 0) {
                                    volume += 10;
                                    double volume1 = volume / 600;
                                    _width = volume / 12 + 4;
                                    if (_width > 56) {
                                      _width = 56;
                                    }
                                    ambientAudio.setVolume(volume1.toDouble());
                                  } else if (details.delta.dx < 0) {
                                    volume -= 10;
                                    double volume1 = volume / 600;
                                    _width = volume / 12 - 4;
                                    ambientAudio.setVolume(volume1.toDouble());
                                    if (_width < 0) {
                                      _width = 0;
                                    }
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 8,
                                  right: 8,
                                ),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    border: _value == 1
                                        ? Border.all(color: Colors.white)
                                        : null,
                                    borderRadius: BorderRadius.circular(8)),
                                height: 56,
                                width: 56,
                                child: _value == 1
                                    ? Image.asset(
                                        'assets/images/nature.png',
                                      )
                                    : Image.asset(
                                        'assets/images/nature_off1.png',
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                left: 8,
                                right: 8,
                              ),
                              padding: const EdgeInsets.all(12.0),
                              decoration: _width > 52
                                  ? BoxDecoration(
                                      color:
                                          _value == 2 ? Colors.white24 : null,
                                      border: _value == 2
                                          ? Border.all(color: Colors.white)
                                          : null,
                                      borderRadius: BorderRadius.circular(8.0),
                                    )
                                  : BoxDecoration(
                                      color:
                                          _value == 2 ? Colors.white24 : null,
                                      border: _value == 2
                                          ? Border.all(color: Colors.white)
                                          : null,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                    ),
                              height: 56,
                              width: _width < 56 && _width >= 0 ? _width : 56,
                              child: const SizedBox(),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_value == 2) {
                                    ambientAudio.pause();
                                    _value = 0;
                                  } else {
                                    _value = 2;
                                  }
                                });
                                if (_value != 0) {
                                  ambientAudio.open(
                                      Audio('assets/audios/campfire.mp3'),
                                      loopMode: LoopMode.playlist);
                                }
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  ambientAudio
                                      .setVolume(volume / 100.toDouble());
                                  if (details.delta.dx > 0) {
                                    volume += 10;
                                    double volume1 = volume / 600;
                                    _width = volume / 12 + 4;
                                    if (_width > 56) {
                                      _width = 56;
                                    }
                                    ambientAudio.setVolume(volume1.toDouble());
                                  } else if (details.delta.dx < 0) {
                                    volume -= 10;
                                    double volume1 = volume / 600;
                                    _width = volume / 12 - 4;
                                    ambientAudio.setVolume(volume1.toDouble());
                                    if (_width < 0) {
                                      _width = 0;
                                    }
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 8,
                                  right: 8,
                                ),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    border: _value == 2
                                        ? Border.all(color: Colors.white)
                                        : null,
                                    borderRadius: BorderRadius.circular(8)),
                                height: 56,
                                width: 56,
                                child: _value == 2
                                    ? Image.asset(
                                        'assets/images/camp_fire.png',
                                      )
                                    : Image.asset(
                                        'assets/images/camp_fire_off1.png',
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                left: 8,
                                right: 8,
                              ),
                              padding: const EdgeInsets.all(12.0),
                              decoration: _width > 52
                                  ? BoxDecoration(
                                      color:
                                          _value == 3 ? Colors.white24 : null,
                                      border: _value == 3
                                          ? Border.all(color: Colors.white)
                                          : null,
                                      borderRadius: BorderRadius.circular(8.0),
                                    )
                                  : BoxDecoration(
                                      color:
                                          _value == 3 ? Colors.white24 : null,
                                      border: _value == 3
                                          ? Border.all(color: Colors.white)
                                          : null,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                    ),
                              height: 56,
                              width: _width < 56 && _width >= 0 ? _width : 56,
                              child: const SizedBox(),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_value == 3) {
                                    ambientAudio.pause();
                                    _value = 0;
                                  } else {
                                    _value = 3;
                                  }
                                });
                                if (_value != 0) {
                                  ambientAudio.open(
                                      Audio('assets/audios/coffeeshop.mp3'),
                                      loopMode: LoopMode.playlist);
                                }
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  ambientAudio
                                      .setVolume(volume / 100.toDouble());
                                  if (details.delta.dx > 0) {
                                    volume += 10;
                                    double volume1 = volume / 600;
                                    _width = volume / 12 + 4;
                                    if (_width > 56) {
                                      _width = 56;
                                    }
                                    ambientAudio.setVolume(volume1.toDouble());
                                  } else if (details.delta.dx < 0) {
                                    volume -= 10;
                                    double volume1 = volume / 600;
                                    _width = volume / 12 - 4;
                                    ambientAudio.setVolume(volume1.toDouble());
                                    if (_width < 0) {
                                      _width = 0;
                                    }
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 8,
                                  right: 8,
                                ),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    border: _value == 3
                                        ? Border.all(color: Colors.white)
                                        : null,
                                    borderRadius: BorderRadius.circular(8)),
                                height: 56,
                                width: 56,
                                child: _value == 3
                                    ? Image.asset(
                                        'assets/images/coffee.png',
                                      )
                                    : Image.asset(
                                        'assets/images/coffee_off1.png',
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20,
                                left: 8,
                                right: 8,
                              ),
                              padding: const EdgeInsets.all(12.0),
                              decoration: _width > 52
                                  ? BoxDecoration(
                                      color:
                                          _value == 4 ? Colors.white24 : null,
                                      border: _value == 4
                                          ? Border.all(color: Colors.white)
                                          : null,
                                      borderRadius: BorderRadius.circular(8.0),
                                    )
                                  : BoxDecoration(
                                      color:
                                          _value == 4 ? Colors.white24 : null,
                                      border: _value == 4
                                          ? Border.all(color: Colors.white)
                                          : null,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                    ),
                              height: 56,
                              width: _width < 56 && _width >= 0 ? _width : 56,
                              child: const SizedBox(),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_value == 4) {
                                    ambientAudio.pause();
                                    _value = 0;
                                  } else {
                                    _value = 4;
                                  }
                                });
                                if (_value != 0) {
                                  ambientAudio.setVolume(1.0);
                                  ambientAudio.open(
                                      Audio('assets/audios/rain.mp3'),
                                      loopMode: LoopMode.playlist);
                                }
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  ambientAudio
                                      .setVolume(volume / 100.toDouble());
                                  if (details.delta.dx > 0) {
                                    volume += 10;
                                    double volume1 = volume / 600;
                                    _width = volume / 12 + 4;
                                    if (_width > 56) {
                                      _width = 56;
                                    }
                                    ambientAudio.setVolume(volume1.toDouble());
                                  } else if (details.delta.dx < 0) {
                                    volume -= 10;
                                    double volume1 = volume / 600;
                                    _width = volume / 12 - 4;
                                    ambientAudio.setVolume(volume1.toDouble());
                                    if (_width < 0) {
                                      _width = 0;
                                    }
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20,
                                  left: 8,
                                  right: 8,
                                ),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    border: _value == 4
                                        ? Border.all(color: Colors.white)
                                        : null,
                                    borderRadius: BorderRadius.circular(8)),
                                height: 56,
                                width: 56,
                                child: _value == 4
                                    ? Image.asset(
                                        'assets/images/rain.png',
                                      )
                                    : Image.asset(
                                        'assets/images/rain_off1.png',
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   GestureDetector SoundButton() {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           if (_value == 3) {
//             ambientAudio.pause();
//             _value = 0;
//           } else {
//             _value = 3;
//           }
//         });
//         if (_value != 0) {
//           ambientAudio.open(Audio('assets/audios/coffeeshop.mp3'),
//               loopMode: LoopMode.playlist);
//         }
//       },
//       onPanUpdate: (details) {
//         setState(() {
//           ambientAudio.setVolume(volume / 100.toDouble());
//           if (details.delta.dx > 0) {
//             volume += 10;
//             double volume1 = volume / 600;
//             _width = volume / 12 + 4;
//             if (_width > 56) {
//               _width = 56;
//             }
//             ambientAudio.setVolume(volume1.toDouble());
//           } else if (details.delta.dx < 0) {
//             volume -= 10;
//             double volume1 = volume / 600;
//             _width = volume / 12 - 4;
//             ambientAudio.setVolume(volume1.toDouble());
//             if (_width < 0) {
//               _width = 0;
//             }
//           }
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.only(
//           bottom: 20,
//           left: 8,
//           right: 8,
//         ),
//         padding: const EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//             color: Colors.white12,
//             border: _value == 3 ? Border.all(color: Colors.white) : null,
//             borderRadius: BorderRadius.circular(8)),
//         height: 56,
//         width: 56,
//         child: _value == 3
//             ? Image.asset(
//                 'assets/images/coffee.png',
//               )
//             : Image.asset(
//                 'assets/images/coffee_off1.png',
//               ),
//       ),
//     );
//   }
}

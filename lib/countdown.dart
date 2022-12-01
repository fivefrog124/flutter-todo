import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class CountdownTimer extends StatefulWidget {
  int countMin;

  CountdownTimer({super.key, required this.countMin});

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
  final audio = AudioPlayer();
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    // ignore: await_only_futures
    countMin = widget.countMin;
    myDuration = Duration(minutes: widget.countMin);

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

    audio.play(
        AssetSource('audios/sfx_amb_forest_spring_afternoon-01-6447.mp3'));
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  dispose() {
    countdownTimer!.cancel();
    countdownTimer2!.cancel();
    audio.stop();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
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
                  AudioPlayer().play(AssetSource('audios/buttonClick.mp3'));
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
                  AudioPlayer().play(AssetSource('audios/buttonClick.mp3'));
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
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
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : cursorVisible
                                    ? null
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            150, 196, 68, 68),
                                        width: 1,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            minutes[0],
                            style: const TextStyle(
                                letterSpacing: 50.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 140),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : cursorVisible
                                    ? null
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            150, 196, 68, 68),
                                        width: 1,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            minutes[1],
                            style: const TextStyle(
                                letterSpacing: 50.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 140),
                          ),
                        ),
                        Opacity(
                          opacity: cursorVisible ? 1 : 0.5,
                          child: const Text(
                            ':',
                            style: TextStyle(
                              letterSpacing: 10.0,
                              color: Colors.white,
                              fontSize: 150,
                              fontFamily: 'Bebas Neue',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : cursorVisible
                                    ? null
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            150, 196, 68, 68),
                                        width: 1,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            seconds[0],
                            style: const TextStyle(
                                letterSpacing: 50.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 140),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : cursorVisible
                                    ? null
                                    : Border.all(
                                        color: const Color.fromARGB(
                                            150, 196, 68, 68),
                                        width: 1,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            seconds[1],
                            style: const TextStyle(
                                letterSpacing: 50.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 140),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    AudioPlayer().play(AssetSource('audios/buttonClick.mp3'));
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
              margin: const EdgeInsets.only(left: 55, bottom: 15),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12)),
                  child: IconButton(
                      color: Colors.white,
                      iconSize: 42.0,
                      onPressed: () {
                        AudioPlayer()
                            .play(AssetSource('audios/buttonClick.mp3'));
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
                _animationController?.forward();
                _animationController = AnimationController(
                    vsync: this, duration: const Duration(milliseconds: 800));
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12)),
                  child: Lottie.asset(
                    'assets/animations/LoudMute_Preview.json',
                    controller: _animationController,
                    height: 100,
                    repeat: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

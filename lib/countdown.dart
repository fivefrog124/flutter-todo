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
  bool lottieStart = true;
  final audio = AudioPlayer();
  final ambientAudio = AudioPlayer();
  AnimationController? _animationController;
  int _value = 0;
  bool isMediaPlayerRunning = false;
  bool forest = false;
  bool campfire = false;
  bool coffee = false;
  bool rain = false;
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

    //playMediaPlayer("sfx_amb_forest_spring_afternoon-01-6447.mp3");

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animationController?.value = 0.58;
  }

  @override
  dispose() {
    countdownTimer!.cancel();
    countdownTimer2!.cancel();

    audio.pause();
    ambientAudio.pause();
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

  playMediaPlayer(String path) {
    if (isMediaPlayerRunning || forest || campfire || coffee || rain) {
      ambientAudio.stop();

      isMediaPlayerRunning = false;
    }
    ambientAudio.play(AssetSource('audios/$path'));

    isMediaPlayerRunning = true;
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
                            color: const Color.fromARGB(18, 255, 255, 255),
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
                                letterSpacing: 60.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 160),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
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
                                        width: 1,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            minutes[1],
                            style: const TextStyle(
                                letterSpacing: 60.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 160),
                          ),
                        ),
                        Opacity(
                          opacity: cursorVisible ? 1 : 0.5,
                          child: const Text(
                            ':',
                            style: TextStyle(
                              letterSpacing: 15.0,
                              color: Colors.white,
                              fontSize: 160,
                              fontFamily: 'Bebas Neue',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
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
                                        width: 1,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            seconds[0],
                            style: const TextStyle(
                                letterSpacing: 60.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 160),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
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
                                        width: 1,
                                      ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            seconds[1],
                            style: const TextStyle(
                                letterSpacing: 60.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 160),
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
              margin: const EdgeInsets.only(left: 55, bottom: 18),
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
                lottieStart = !lottieStart;

                if (lottieStart) {
                  //_animationController?.forward();

                  _animationController?.animateTo(0.58);

                  audio.resume();
                  // ignore: avoid_print
                  print("ileri");
                } else {
                  _animationController?.reverse();
                  audio.pause();
                  // ignore: avoid_print
                  print("reverse");
                }
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12)),
                  child: Lottie.asset(
                    'assets/animations/LoudMute_Preview.json',
                    controller: _animationController,
                    height: 60,
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
                  GestureDetector(
                    onTap: () => setState(() {
                      _value = 1;
                      forest = !forest;
                      if (forest) {
                        playMediaPlayer("forest.mp3");
                        // ignore: avoid_print
                        print('_value: $_value');
                      } else {
                        ambientAudio.pause();
                      }
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        left: 8,
                        right: 8,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          border: _value == 1 && forest
                              ? Border.all(color: Colors.white)
                              : null,
                          borderRadius: BorderRadius.circular(8)),
                      height: 56,
                      width: 56,
                      child: _value == 1 && forest
                          ? Image.asset(
                              'assets/images/nature.png',
                            )
                          : Image.asset(
                              'assets/images/nature_off1.png',
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _value = 2;
                      campfire = !campfire;
                      if (campfire) {
                        playMediaPlayer("campfire.mp3");
                        print('_value: $_value');
                      } else {
                        ambientAudio.pause();
                      }
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        left: 8,
                        right: 8,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          border: _value == 2 && campfire
                              ? Border.all(color: Colors.white)
                              : null,
                          borderRadius: BorderRadius.circular(8)),
                      height: 56,
                      width: 56,
                      child: _value == 2 && campfire
                          ? Image.asset(
                              'assets/images/camp_fire.png',
                            )
                          : Image.asset(
                              'assets/images/camp_fire_off1.png',
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _value = 3;
                      coffee = !coffee;
                      if (coffee) {
                        playMediaPlayer("coffeeshop.mp3");
                      } else {
                        ambientAudio.pause();
                      }
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        left: 8,
                        right: 8,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          border: _value == 3 && coffee
                              ? Border.all(color: Colors.white)
                              : null,
                          borderRadius: BorderRadius.circular(8)),
                      height: 56,
                      width: 56,
                      child: _value == 3 && coffee
                          ? Image.asset(
                              'assets/images/coffee.png',
                            )
                          : Image.asset(
                              'assets/images/coffee_off1.png',
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _value = 4;
                      rain = !rain;
                      if (rain) {
                        playMediaPlayer("rain.mp3");
                      } else {
                        ambientAudio.pause();
                      }
                    }),
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        left: 8,
                        right: 8,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          border: _value == 4 && rain
                              ? Border.all(color: Colors.white)
                              : null,
                          borderRadius: BorderRadius.circular(8)),
                      height: 56,
                      width: 56,
                      child: _value == 4 && rain
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
        ),
      ),
    );
  }
}

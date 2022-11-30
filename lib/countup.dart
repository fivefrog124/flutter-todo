import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

// ignore: must_be_immutable
class CountdownTimer1 extends StatefulWidget {
  const CountdownTimer1({super.key});

  @override
  State<CountdownTimer1> createState() => _CountdownTimer1State();
}

class _CountdownTimer1State extends State<CountdownTimer1> {
  Timer? countdownTimer1;

  late int countMin;
  late Duration myDuration;
  bool cursorVisible = true;
  bool startStop = true;

  @override
  void initState() {
    super.initState();

    // ignore: await_only_futures

    myDuration = const Duration(hours: 0);

    countdownTimer1 = Timer.periodic(const Duration(seconds: 1), (_) {
      cursorVisible ? cursorVisible = false : cursorVisible = true;
      setState(() {});
      setCountDown();
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    countdownTimer1!.cancel();
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
      countdownTimer1 = Timer.periodic(const Duration(seconds: 1), (_) {
        cursorVisible ? cursorVisible = false : cursorVisible = true;

        setCountDown();
      });
      startStop = true;
    });
  }

  stopTimer() {
    setState(() {
      startStop = false;
      countdownTimer1!.cancel();
    });
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds + reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer1!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final hours = strDigits(myDuration.inHours.remainder(24));
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
                    fontSize: 17,
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
                  countdownTimer1!.cancel();

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
        countdownTimer1!.cancel();
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
                                : Border.all(
                                    color: Color.fromARGB(113, 244, 67, 54),
                                    width: 3,
                                  ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            hours[0],
                            style: const TextStyle(
                                letterSpacing: 40.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 115),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : Border.all(
                                    color: Color.fromARGB(113, 244, 67, 54),
                                    width: 3,
                                  ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            hours[1],
                            style: const TextStyle(
                                letterSpacing: 40.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 115),
                          ),
                        ),
                        Opacity(
                          opacity: cursorVisible ? 1 : 0.5,
                          child: const Text(
                            ':',
                            style: TextStyle(
                              letterSpacing: 10.0,
                              color: Colors.white,
                              fontSize: 130,
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
                                : Border.all(
                                    color: Color.fromARGB(113, 244, 67, 54),
                                    width: 3,
                                  ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            minutes[0],
                            style: const TextStyle(
                                letterSpacing: 40.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 115),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : Border.all(
                                    color: Color.fromARGB(113, 244, 67, 54),
                                    width: 3,
                                  ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            minutes[1],
                            style: const TextStyle(
                                letterSpacing: 40.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 115),
                          ),
                        ),
                        Opacity(
                          opacity: cursorVisible ? 1 : 0.5,
                          child: const Text(
                            ':',
                            style: TextStyle(
                              letterSpacing: 10.0,
                              color: Colors.white,
                              fontSize: 130,
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
                                : Border.all(
                                    color: Color.fromARGB(113, 244, 67, 54),
                                    width: 3,
                                  ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            seconds[0],
                            style: const TextStyle(
                                letterSpacing: 40.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 115),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12),
                            border: startStop
                                ? null
                                : Border.all(
                                    color: Color.fromARGB(113, 244, 67, 54),
                                    width: 3,
                                  ),
                          ),
                          margin: const EdgeInsets.all(8),
                          child: Text(
                            seconds[1],
                            style: const TextStyle(
                                letterSpacing: 40.0,
                                fontFamily: 'Bebas Neue',
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 115),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(14.0),
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
                      onPressed: () => startOrStop(),
                      icon: startStop
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

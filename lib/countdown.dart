import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';

// ignore: must_be_immutable
class CountdownTimer extends StatefulWidget {
  int countMin;

  CountdownTimer({super.key, required this.countMin});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countdownTimer;

  late int countMin;
  late Duration myDuration;
  bool cursorVisible = true;

  @override
  void initState() {
    super.initState();

    // ignore: await_only_futures
    countMin = widget.countMin;
    myDuration = Duration(minutes: widget.countMin);

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnaSayfa(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(right: 10),
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

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          minutes[0],
                          style: const TextStyle(
                              letterSpacing: 70.0,
                              fontFamily: 'Bebas Neue',
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 165),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          minutes[1],
                          style: const TextStyle(
                              letterSpacing: 70.0,
                              fontFamily: 'Bebas Neue',
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 165),
                        ),
                      ),
                      Opacity(
                        opacity: cursorVisible ? 1 : 0.5,
                        child: const Text(
                          ':',
                          style: TextStyle(
                            letterSpacing: 70.0,
                            color: Colors.white,
                            fontSize: 217,
                            fontFamily: 'Bebas Neue',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          seconds[0],
                          style: const TextStyle(
                              letterSpacing: 70.0,
                              fontFamily: 'Bebas Neue',
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 165),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.all(8),
                        child: Text(
                          seconds[1],
                          style: const TextStyle(
                              letterSpacing: 70.0,
                              fontFamily: 'Bebas Neue',
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 165),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // RichText(
              //   text: TextSpan(text: null, children: [
              //     TextSpan(
              //       text: minutes[0],
              //       style: const TextStyle(
              //           letterSpacing: 70.0,
              //           fontFamily: 'Bebas Neue',
              //           fontWeight: FontWeight.normal,
              //           color: Colors.white,
              //           fontSize: 165),
              //     ),
              //     TextSpan(
              //       text: minutes[1],
              //       style: const TextStyle(
              //           letterSpacing: 70.0,
              //           fontFamily: 'Bebas Neue',
              //           fontWeight: FontWeight.normal,
              //           color: Colors.white,
              //           fontSize: 165),
              //     ),
              //     const TextSpan(
              //       text: ':',
              //       style: TextStyle(
              //         letterSpacing: 70.0,
              //         color: Colors.white,
              //         fontSize: 217,
              //         fontFamily: 'Bebas Neue',
              //       ),
              //     ),
              //     TextSpan(
              //       text: seconds[0],
              //       style: const TextStyle(
              //           letterSpacing: 70.0,
              //           fontFamily: 'Bebas Neue',
              //           fontWeight: FontWeight.normal,
              //           color: Colors.white,
              //           fontSize: 165),
              //     ),
              //     TextSpan(
              //       text: seconds[1],
              //       style: const TextStyle(
              //           letterSpacing: 70.0,
              //           fontFamily: 'Bebas Neue',
              //           fontWeight: FontWeight.normal,
              //           color: Colors.white,
              //           fontSize: 165),
              //     )
              //   ]),
              // ),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}

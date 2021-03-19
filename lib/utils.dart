import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Utils {
  static final List<Flushbar> flushBars = [];

  static void showSnackBar(
    BuildContext context, {
    required String text,
  }) =>
      _show(
        context,
        Flushbar(
          messageText: Center(
              child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 24),
          )),
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.black,
          animationDuration: Duration(microseconds: 0),
        ),
      );

  static Future _show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }
}

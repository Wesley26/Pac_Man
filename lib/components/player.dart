import 'package:flutter/material.dart';

/*
 * MyPlayer - class returns Pac_Man image asset.
 */

class MyPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset('lib/images/pac_man.png'),
    );
  }
}

import 'package:flutter/material.dart';

/*
 * RedGhost - class returns Red Ghost Blinky image asset.
 */

class RedGhost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset('lib/images/blinky_ghost.png'),
    );
  }
}

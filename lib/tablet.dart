import 'package:flutter/cupertino.dart';

import 'main.dart';

class Tablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Tablet ${deviceSize(context).toInt()}'));
  }
}
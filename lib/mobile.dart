import 'package:flutter/cupertino.dart';

import 'main.dart';

class Mobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Mobile ${deviceSize(context).toInt()}'));
  }
}
import 'package:flutter/cupertino.dart';

import 'main.dart';

class Desktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Desktop ${deviceSize(context).toInt()}'));
  }
}
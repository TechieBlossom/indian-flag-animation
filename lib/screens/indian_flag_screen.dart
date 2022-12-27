import 'package:flutter/material.dart';
import 'package:indian_flag/widgets/indian_flag.dart';

class IndianFlagScreen extends StatefulWidget {
  const IndianFlagScreen({Key? key}) : super(key: key);

  @override
  State<IndianFlagScreen> createState() => _IndianFlagScreenState();
}

class _IndianFlagScreenState extends State<IndianFlagScreen> {
  bool _animated = false;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white10,
      body: IndianFlag(sw: sw, sh: sh, animated: _animated),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _animated = !_animated;
          });
        },
        label: Text(_animated ? 'Reset' : 'Animate'),
      ),
    );
  }
}

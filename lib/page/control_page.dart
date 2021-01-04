import 'package:flutter/material.dart';

class ControllPage extends StatefulWidget {
  const ControllPage({Key key, this.controller}) : super(key: key);

  final PageController controller;

  @override
  _ControllPageState createState() => _ControllPageState();
}

class _ControllPageState extends State<ControllPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              tooltip: '返回主页',
              iconSize: 48,
              onPressed: () {
                widget.controller.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.bounceOut,
                );
              },
              icon: Center(
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

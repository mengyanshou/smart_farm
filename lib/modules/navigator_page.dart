import 'package:flutter/material.dart';
import 'package:smart_farm/line_chart_page.dart';
import 'package:smart_farm/modules/overview/pages/overview_page.dart';

import 'control/pages/control_page.dart';
import 'mine/pages/mine_page.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigationPageState();
  }
}

class NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // return Material(
    //   child: LineChartPage(),
    // );
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '概览',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.devices,
            ),
            label: '设备',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.mood,
            ),
            label: '我的',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int i) {
          _currentIndex = i;
          setState(() {});
        },
      ),
      body: [
        OverviewPage(),
        ControllPage(),
        MinePage(),
      ][_currentIndex],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_farm/config/candy_colors.dart';
import 'package:smart_farm/config/dimens.dart';
import 'package:smart_farm/samples/line_chart_sample1.dart';

/// 室外土壤温湿度
class OutsideSoilTH extends StatefulWidget {
  @override
  _OutsideSoilTHState createState() => _OutsideSoilTHState();
}

class _OutsideSoilTHState extends State<OutsideSoilTH> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 8.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/Temperature-humidity.svg',
                width: Dimens.gap_dp40,
                height: Dimens.gap_dp40,
                color: CandyColors.candyGreen,
              ),
              SizedBox(
                width: Dimens.gap_dp8,
              ),
              Text(
                '室外土壤温湿度',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 28,
              right: 28,
            ),
            child: LineChartSample1(),
          ),
        ],
      ),
    );
  }
}

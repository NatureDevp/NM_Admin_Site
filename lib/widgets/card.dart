import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/_system.dart';

class CustomCard extends StatelessWidget {
  CustomCard({
    super.key,
    required this.cardTitle,
    required this.titleBackground,
    required this.barSize,
    required this.barColor,
    required this.currentBarCount,
    required this.totalBarCount,
    required this.cardSubtitle,
    required this.overallDataCount,
    required this.imagePath,
    required this.cardBackgroud,
    required this.borderColor,
    required this.displayTotalBar,
  });
  String cardTitle;
  String cardSubtitle;
  Color cardBackgroud;
  Color borderColor;
  Color titleBackground;
  String imagePath;
  double barSize;
  Color barColor;
  double currentBarCount;
  double totalBarCount;
  double overallDataCount;
  bool displayTotalBar;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(size.width * 0.01),
      width: size.width * 0.34,
      height: size.width * 0.11,
      decoration: BoxDecoration(
        color: cardBackgroud,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTitle(
                cardTitle: cardTitle,
                backgroundColor: titleBackground,
              ),
              const Gap(30),
              CustomBarGraph(
                barSize: barSize,
                barColor: barColor,
                currentCount: currentBarCount,
                totalCount: totalBarCount,
              ),
              const Gap(12),
              CardData(
                cardSubtitle: cardSubtitle,
                currentDataCount: currentBarCount,
                totalDataCount: totalBarCount,
                overallCount: overallDataCount,
                isdisplayTotalBar: displayTotalBar,
              ),
            ],
          ),
          Image.asset(imagePath),
        ],
      ),
    );
  }
}

class CardTitle extends StatelessWidget {
  CardTitle({
    super.key,
    required this.cardTitle,
    required this.backgroundColor,
  });
  String cardTitle;
  Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        cardTitle,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class CustomBarGraph extends StatelessWidget {
  CustomBarGraph({
    super.key,
    required this.barSize,
    required this.barColor,
    required this.currentCount,
    required this.totalCount,
  });
  Color barColor;
  double barSize;
  double totalCount;
  double currentCount;

  double calculatePercentage() {
    double totalPercentage = (currentCount / totalCount);
    totalPercentage = (barSize * totalPercentage);
    return totalPercentage;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: barSize <= 300 ? barSize : 300,
      height: 8,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: SystemColor.lightGrey,
      ),
      child: Container(
        width: calculatePercentage(),
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: barColor,
        ),
      ),
    );
  }
}

class CardData extends StatelessWidget {
  CardData({
    super.key,
    required this.cardSubtitle,
    required this.currentDataCount,
    required this.totalDataCount,
    required this.overallCount,
    required this.isdisplayTotalBar,
  });
  double currentDataCount;
  double totalDataCount;
  double overallCount;
  String cardSubtitle;
  bool isdisplayTotalBar;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: isdisplayTotalBar ? '$totalDataCount' : '$currentDataCount',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: '/$overallCount',
                style: TextStyle(
                  color: SystemColor.mediumGrey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Text(
          cardSubtitle,
          style: TextStyle(
            color: SystemColor.mediumGrey,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

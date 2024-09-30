import 'package:flutter/material.dart';

import '../widgets/card.dart';
import '../widgets/card2.dart.dart';
import '../widgets/card3.dart';

class SystemColor {
  static Color dimBlue = const Color(0xff101720);
  static Color neutralWHite = const Color(0xffF8F8FF);
  static Color lightGrey = const Color(0xffCFD1D2);
  static Color mediumGrey = const Color(0xff707479);
  static Color primary = const Color(0xff03A678);
  static Color primaryLighter = const Color(0xffB4E5D7);
  static Color secondary = const Color(0xffF1D077);
  static Color secondaryLighter = const Color(0xffFBF1D7);
}

class SystemTitle {
  static String title1 = 'NatureMedix';
}

class SystemCard {
  static Widget cardStyle1({
    required String cardTitle,
    required String cardSubtitle,
    required Color titleBackground,
    required String imagePath,
    required double barSize,
    required Color barColor,
    required double currentBarCount,
    required double totalBarCount,
    required double overallDataCount,
    required Color cardBackgroud,
    required Color borderColor,
    bool displayTotalBarCount = true,
    required Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: CustomCard(
        cardBackgroud: cardBackgroud,
        borderColor: borderColor,
        cardTitle: cardTitle,
        titleBackground: titleBackground,
        barSize: barSize,
        barColor: barColor,
        currentBarCount: currentBarCount,
        totalBarCount: totalBarCount,
        cardSubtitle: cardSubtitle,
        overallDataCount: overallDataCount,
        imagePath: imagePath,
        displayTotalBar: displayTotalBarCount,
      ),
    );
  }

  static Widget cardStyle2({
    required String cardTitle,
    required Color titleBackground,
    required Color cardBackgroud,
    required Color borderColor,
    required Function()? onSeeAll,
  }) {
    return CustomCard2(
      cardBackgroud: cardBackgroud,
      borderColor: borderColor,
      cardTitle: cardTitle,
      titleBackground: titleBackground,
      onSeeAll: onSeeAll,
    );
  }

  static Widget cardStyle3({
    required String imagePaht,
    required String title,
    required String subtitle,
    required bool isNew,
    required Function()? ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: CustomCard3(
        imagePath: imagePaht,
        title: title,
        subtitle: subtitle,
        isNew: isNew,
      ),
    );
  }
}

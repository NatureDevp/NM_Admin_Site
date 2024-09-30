import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../color/colors.dart';
import '../utils/_system.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard({
    super.key,
    required this.cardTitle,
    required this.titleBackground,
    required this.barColor,
    required this.currentBarCount,
    required this.totalBarCount,
    required this.cardSubtitle,
    required this.imagePath,
    required this.cardBackgroud,
    required this.borderColor,
  });
  String cardTitle;
  String cardSubtitle;
  Color cardBackgroud;
  Color borderColor;
  Color titleBackground;
  String imagePath;
  Color barColor;
  double currentBarCount;
  double totalBarCount;
  double barsize = 0.0;
  var screensSize;
  @override
  Widget build(BuildContext context) {
    screensSize = MediaQuery.of(context).size;

    //
    return Container(
      padding: EdgeInsets.all(screensSize.width * 0.01),
      width: screensSize.width * 0.34,
      height: screensSize.width * 0.128,
      decoration: BoxDecoration(
        color: cardBackgroud,
        borderRadius: BorderRadius.circular(screensSize.width * 0.012),
        border: Border.all(
          color: borderColor,
        ),
      ),

      //
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                barsize = constraints.maxWidth;

                //
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardTitleStyle(),
                    Gap(screensSize.width * 0.025),
                    barGraph(),
                    Gap(screensSize.width * 0.01),
                    cardData(),
                  ],
                );
              },
            ),
          ),

          //
          const Gap(25),

          //
          Expanded(
            flex: 1,
            child: Image.asset(
              imagePath,
              width: screensSize.width * 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget cardTitleStyle() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screensSize.width * 0.005,
        vertical: screensSize.width * 0.002,
      ),
      decoration: BoxDecoration(
        color: titleBackground,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        cardTitle,
        style: TextStyle(
          color: Colors.black,
          fontSize: screensSize.width * 0.01,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //
  Widget barGraph() {
    return Container(
      height: screensSize.width * 0.006,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screensSize.width * 0.006),
        color: SystemColor.lightGrey,
      ),
      child: Container(
        width: calculatePercentage(),
        height: screensSize.width * 0.006,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screensSize.width * 0.006),
          color: barColor,
        ),
      ),
    );
  }

  double calculatePercentage() {
    double totalPercentage = (currentBarCount / totalBarCount);
    totalPercentage = (barsize * totalPercentage);
    return totalPercentage;
  }

  Widget cardData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: '$currentBarCount',
            style: TextStyle(
              color: Colors.black,
              fontSize: barsize * 0.11,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: '/$totalBarCount',
                style: TextStyle(
                  color: SystemColor.mediumGrey,
                  fontSize: barsize * 0.06,
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
            fontSize: barsize * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

//===============================

class DashboardRequestCard extends StatelessWidget {
  DashboardRequestCard({
    super.key,
    required this.cardTitle,
    required this.titleBackground,
    required this.cardBackgroud,
    required this.borderColor,
    required this.onSeeAll,
  });
  String cardTitle;
  Color cardBackgroud;
  Color borderColor;
  Color titleBackground;
  Function()? onSeeAll;
  var screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.01),
      width: screenSize.width * 0.44,
      height: screenSize.width * 0.266,
      decoration: BoxDecoration(
        color: cardBackgroud,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
        ),
      ),

      //
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cardTitleStye(),
          Expanded(
            child: _cardBody(),
          ),
        ],
      ),
    );
  }

  Widget _cardTitleStye() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.016,
            vertical: screenSize.width * 0.002,
          ),
          decoration: BoxDecoration(
            color: titleBackground,
            borderRadius: BorderRadius.circular(screenSize.width * 0.004),
          ),
          child: Text(
            cardTitle,
            style: TextStyle(
              color: CustomColors.dark.original,
              fontSize: screenSize.width * 0.01,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: Text(
            'See all',
            style: TextStyle(
              color: CustomColors.dark.original,
              fontSize: screenSize.width * 0.01,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardBody() {
    return LayoutBuilder(builder: (context, constraint) {
      return SizedBox(
        height: constraint.maxHeight,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: screenSize.width * 0.01),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {},
                child: _cardTile(),
              );
            }),
      );
    });
  }

  Widget _cardTile() {
    return Card(
      color: SystemColor.neutralWHite,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenSize.width * 0.01,
          horizontal: screenSize.width * 0.02,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _plantDetail(),
            Gap(screenSize.width * 0.06),
            _requestDetail(),
            const Spacer(),
            _banner(),
          ],
        ),
      ),
    );
  }

  Widget _plantDetail() {
    return Row(
      children: [
        Image.asset(
          'assets/images/image1.png',
          height: screenSize.width * 0.04,
        ),
        Gap(screenSize.width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Tawa-tawa',
              style: TextStyle(
                fontSize: screenSize.width * 0.0125,
                fontWeight: FontWeight.bold,
                color: CustomColors.dark.original,
              ),
            ),
            Text(
              '[Euphorbia hirta]',
              style: TextStyle(
                fontSize: screenSize.width * 0.009,
                fontWeight: FontWeight.w400,
                color: CustomColors.dark.original,
              ),
            ),
          ],
        ),
      ],
    );
  }

//
  Widget _requestDetail() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'June 06, 2024',
            style: TextStyle(
              fontSize: screenSize.width * 0.011,
              fontWeight: FontWeight.w800,
              color: CustomColors.dark.original,
            ),
          ),
          Text(
            'Requested date',
            style: TextStyle(
              fontSize: screenSize.width * 0.009,
              fontWeight: FontWeight.w300,
              color: CustomColors.dark.medium,
            ),
          ),
        ]);
  }

//
  Widget _banner() {
    return Container(
      padding: EdgeInsets.all(screenSize.width * 0.003),
      decoration: BoxDecoration(
        color: SystemColor.primary,
        borderRadius: BorderRadius.circular(screenSize.width * 0.005),
      ),
      child: Text(
        'New',
        style: TextStyle(
          color: Colors.white,
          fontSize: screenSize.width * 0.009,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

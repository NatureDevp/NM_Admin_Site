import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/_system.dart';

class CustomCard2 extends StatelessWidget {
  CustomCard2({
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(size.width * 0.01),
        width: size.width * 0.44,
        height: (size.width * 0.1) * 2.269,
        decoration: BoxDecoration(
          color: cardBackgroud,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardTitle(
              cardTitle: cardTitle,
              backgroundColor: titleBackground,
              seeAll: onSeeAll,
            ),
            const CardBody(),
          ],
        ));
  }
}

class CardTitle extends StatelessWidget {
  CardTitle({
    super.key,
    required this.cardTitle,
    required this.backgroundColor,
    required this.seeAll,
  });
  String cardTitle;
  Color backgroundColor;
  Function()? seeAll;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
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
        ),
        TextButton(
          onPressed: seeAll,
          child: const Text('See all'),
        ),
      ],
    );
  }
}

class CardBody extends StatelessWidget {
  const CardBody({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width * 0.18,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          shrinkWrap: true,
          itemCount: 30,
          itemBuilder: (_, index) {
            return InkWell(
              onTap: () {},
              child: Card(
                color: SystemColor.neutralWHite,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/image1.png',
                            height: 70,
                          ),
                          const Gap(20),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Tawa-tawa',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Euphorbia hirta',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(100),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dave12',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '#2345',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: SystemColor.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Text(
                          'New',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

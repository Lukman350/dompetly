import 'package:dompetly/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoalProgressCard extends StatelessWidget {
  final double progress;
  final String title;

  const GoalProgressCard({
    super.key,
    this.progress = 0.75,
    this.title = "Savings On Goals",
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(31)),
      child: InkWell(
        onTap: () {
          // TODO: Implement the action when the card is tapped
          print("Goal Progress Card tapped");
        },
        child: Container(
          height: 152,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          decoration: BoxDecoration(
            color: AppColors.mainGreen,
            borderRadius: BorderRadius.all(Radius.circular(31)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 68,
                          height: 68,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 4,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/images/icons/car_icon.svg'
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 2, height: 108, color: Colors.white),
              const SizedBox(width: 15),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          SvgPicture.asset('assets/images/icons/dollar_bucks.svg'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Revenue Last Week',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Rp 10.000.000',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 2,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Row(
                        spacing: 10,
                        children: [
                          SvgPicture.asset('assets/images/icons/food_icon.svg'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Food Last Week',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                '-Rp 100.000',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

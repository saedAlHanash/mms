import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/strings/app_color_manager.dart';
import 'circle_indicator.dart';

class MyTabWidget extends StatelessWidget {
  const MyTabWidget({
    Key? key,
    required this.tabs,
    this.height,
    required this.tabsView,
  }) : super(key: key);

  final List<Widget> tabs;
  final List<Widget> tabsView;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            indicator:
                CircleTabIndicator(color: AppColorManager.mainColor, radius: 3),
            labelColor: AppColorManager.mainColor,

            unselectedLabelColor: AppColorManager.textColor,

            tabs: tabs,
          ),
          Transform.scale(
              scaleX: 1.5,
              child: Divider(height: 30.0.h, indent: 0, endIndent: 0)),
          SizedBox(
            height: height ?? 300.0.h,
            child: TabBarView(
              children: tabsView,
            ),
          ),
        ],
      ),
    );
  }
}

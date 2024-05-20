import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../committees/ui/pages/committee_screen.dart';
import '../../../committees/ui/widget/committee_widget.dart';
import '../../../meetings/ui/pages/calender_screen.dart';
import '../widget/bottom_nav_widget.dart';
import '../widget/menu_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: pageIndex == 0,
      onPopInvoked: (didPop) {
        if (pageIndex != 0) {
          pageIndex = 0;
          setState(() => _pageController.jumpToPage(0));
        }
      },
      child: Scaffold(
        bottomNavigationBar: NewNav(
          onChange: (index) {
            pageIndex = index;
            setState(() => _pageController.jumpToPage(index));
          },
          controller: _pageController,
        ),
        appBar: const AppBarWidget(zeroHeight: true),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const CommitteeScreen(),
              Container(color: Colors.red),
              const CalenderScreen(),
              const MenuScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

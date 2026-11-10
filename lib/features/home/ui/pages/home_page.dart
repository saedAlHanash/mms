import 'package:flutter/material.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/features/committees/ui/pages/committee_screen.dart';
import 'package:mms/features/home/ui/widget/bottom_nav_widget.dart';
import 'package:mms/features/home/ui/widget/menu_screen.dart';
import 'package:mms/features/meetings/ui/pages/calender_screen.dart';

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
        // The floating nav bar sits over the tabs; each tab adds bottom padding.
        extendBody: true,
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
            children: const [
              CommitteeScreen(),
              CalenderScreen(),
              MenuScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

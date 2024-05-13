// import 'package:mms/core/strings/app_color_manager.dart';
// import 'package:mms/core/strings/app_string_manager.dart';
// import 'package:mms/core/util/my_style.dart';
//
// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:drawable_text/drawable_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
// import '../../../../generated/assets.dart';
// import 'package:image_multi_type/image_multi_type.dart';
//
// import '../util/my_style.dart';
//
// class BottomNavigator extends StatefulWidget {
//   const BottomNavigator({Key? key, required this.onChange}) : super(key: key);
//
//   final Function(int) onChange;
//
//   @override
//   State<BottomNavigator> createState() => BottomNavigatorState();
// }
//
// class BottomNavigatorState extends State<BottomNavigator> {
//   var selectedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 54.0.h,
//       width: 1.0.sw,
//       clipBehavior: Clip.hardEdge,
//       decoration: BoxDecoration(
//         border: MyStyle.appBorderAll,
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(26.0.r),
//         ),
//       ),
//       child: BottomNavyBar(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         selectedIndex: selectedIndex,
//         itemCornerRadius: 30.0.r,
//         onItemSelected: (value) {
//           setState(() => selectedIndex = value);
//           widget.onChange(value);
//         },
//         backgroundColor: AppColorManager.f6,
//         showElevation: true,
//         items: [
//           BottomNavyBarItem(
//             icon: const ImageMultiType(url:Assets.iconsHouseFill),
//             title: DrawableText(text: AppStringManager.home, size: 14.0.sp),
//             activeColor: AppColorManager.mainColor,
//             inactiveColor: AppColorManager.mainColor,
//           ),
//           BottomNavyBarItem(
//             icon: const ImageMultiType(url:Assets.iconsJournalCheck),
//             title: DrawableText(text: AppStringManager.courses, size: 14.0.sp),
//             activeColor: AppColorManager.mainColor,
//             inactiveColor: AppColorManager.mainColor,
//           ),
//           BottomNavyBarItem(
//             icon: const ImageMultiType(url:Assets.iconsCourses),
//             title: DrawableText(text: AppStringManager.liaisons, size: 14.0.sp),
//             activeColor: AppColorManager.mainColor,
//             inactiveColor: AppColorManager.mainColor,
//           ),
//           BottomNavyBarItem(
//             icon: const ImageMultiType(url:Assets.iconsPersonFillGear),
//             title: DrawableText(text: AppStringManager.profile, size: 14.0.sp),
//             activeColor: AppColorManager.mainColor,
//             inactiveColor: AppColorManager.mainColor,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // class MyHomePage extends StatefulWidget {
// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }
// //
// // class _MyHomePageState extends State<MyHomePage> {
// //   int _currentIndex = 0;
// //   late PageController _pageController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _pageController = PageController();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _pageController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Bottom Nav Bar")),
// //       body: SizedBox.expand(
// //         child: PageView(
// //           controller: _pageController,
// //           onPageChanged: (index) {
// //             setState(() => _currentIndex = index);
// //           },
// //           children: <Widget>[
// //             Container(
// //               color: Colors.blueGrey,
// //             ),
// //             Container(
// //               color: Colors.red,
// //             ),
// //             Container(
// //               color: Colors.green,
// //             ),
// //             Container(
// //               color: Colors.blue,
// //             ),
// //           ],
// //         ),
// //       ),
// //       bottomNavigationBar: BottomNavyBar(
// //         selectedIndex: _currentIndex,
// //         onItemSelected: (index) {
// //           setState(() => _currentIndex = index);
// //           _pageController.jumpToPage(index);
// //         },
// //         items: <BottomNavyBarItem>[
// //           BottomNavyBarItem(title: Text('Item One'), icon: Icon(Icons.home)),
// //           BottomNavyBarItem(title: Text('Item Two'), icon: Icon(Icons.apps)),
// //           BottomNavyBarItem(
// //               title: Text('Item Three'), icon: Icon(Icons.chat_bubble)),
// //           BottomNavyBarItem(
// //               title: Text('Item Four'), icon: Icon(Icons.settings)),
// //         ],
// //       ),
// //     );
// //   }
// // }

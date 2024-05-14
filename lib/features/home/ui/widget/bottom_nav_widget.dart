import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../generated/assets.dart';

class NewNav extends StatefulWidget {
  const NewNav({
    super.key,
    required this.controller,
    required this.onChange,
  });

  final PageController controller;
  final Function(int) onChange;

  @override
  State<NewNav> createState() => _NewNavState();
}

class _NewNavState extends State<NewNav> {
  int selectedIndex = 0;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() => selectedIndex = widget.controller.page!.toInt());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 14.0).r,
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: AppColorManager.e6,width: 1.0.r),
        borderRadius: BorderRadius.circular(1000.r),
        boxShadow: [
          BoxShadow(
            color: AppColorManager.black.withOpacity(0.09),
            blurRadius: 30.r,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          fontFamily: FontManager.cairoSemiBold.name,
          fontSize: 12.0.sp,
          color: AppColorManager.black,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: FontManager.cairoSemiBold.name,
          fontSize: 12.0.sp,
          color: AppColorManager.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageMultiType(
              url: Icons.home,
              color: Colors.grey,
              height: 25.0.spMin,
            ),
            activeIcon: ImageMultiType(
              url: Icons.home,
              color: AppColorManager.mainColor,
              height: 25.0.spMin,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageMultiType(
              url: Icons.file_copy_sharp,
              color: Colors.grey,
              height: 25.0.spMin,
            ),
            activeIcon: ImageMultiType(
              url: Icons.file_copy_sharp,
              color: AppColorManager.mainColor,
              height: 25.0.spMin,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageMultiType(
              url: Icons.calendar_month,
              color: Colors.grey,
              height: 25.0.spMin,
            ),
            activeIcon: ImageMultiType(
              url: Icons.calendar_month,
              color: AppColorManager.mainColor,
              height: 25.0.spMin,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageMultiType(
              url: Icons.print,
              color: Colors.grey,
              height: 25.0.spMin,
            ),
            activeIcon: ImageMultiType(
              url: Icons.print,
              color: AppColorManager.mainColor,
              height: 25.0.spMin,
            ),
            label: '',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (value) {
          // if (context.read<ProfileCubit>().state.statuses.loading) return;
          widget.onChange.call(value);
          setState(() => selectedIndex = value);
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

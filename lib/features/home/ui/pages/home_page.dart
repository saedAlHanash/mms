import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/features/committees/ui/widget/committee_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(zeroHeight: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColorManager.mainColor,
        child: ImageMultiType(url: Icons.add, color: Colors.white),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            40.0.verticalSpace,
            CommitteesWidget(),
            MyButton(
              onTap: () {
                AppProvider.logout();
              },
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}

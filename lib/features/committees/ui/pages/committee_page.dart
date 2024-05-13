import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../bloc/committee_cubit/committee_cubit.dart';

class CommitteePage extends StatelessWidget {
  const CommitteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: BlocBuilder<CommitteeCubit, CommitteeInitial>(
          builder: (context, state) {
            return DrawableText(
              fontWeight: FontWeight.bold,
              text: state.result.name,
              size: 24.0.sp,
              fontFamily: FontManager.cairoBold.name,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0).r,
        child: BlocBuilder<CommitteeCubit, CommitteeInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            final item = state.result;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCardWidget(
                  radios: 15.0.r,
                  child: DrawableText(
                    fontFamily: FontManager.cairoBold.name,
                    size: 18.0.sp,
                    text: item.name,
                    matchParent: true,
                    drawableEnd: DrawableText(
                      size: 18.0.sp,
                      text: item.formationDate?.formatDate ?? '',
                    ),
                  ),
                ),
                20.0.verticalSpace,
                DrawableText.title(
                  text: 'Description',
                  padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                ),
                DrawableText(
                  padding: const EdgeInsets.all(20.0).r,
                  color: Colors.grey,
                  text: item.description,
                  maxLines: 3,
                  matchParent: true,
                ),
                20.0.verticalSpace,
                DrawableText.title(
                  text: 'Statement',
                  padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                ),
                DrawableText(
                  padding: const EdgeInsets.all(20.0).r,
                  color: Colors.grey,
                  text: item.statement,
                  maxLines: 3,
                  matchParent: true,
                ),
                SizedBox(
                  height: 200.0.h,
                  width: 1.0.sw,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, i) {
                      return Container();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

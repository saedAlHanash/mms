import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/snack_bar_message.dart';
import 'package:mms/core/widgets/not_found_widget.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/saed_taple_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../router/app_router.dart';
import '../../bloc/my_committees_cubit/my_committees_cubit.dart';

class CommitteesWidget extends StatelessWidget {
  const CommitteesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCommitteesCubit, MyCommitteesInitial>(
      builder: (context, state) {
        if (state.statuses.loading) {
          return MyStyle.loadingWidget();
        }

        final list = state.result;
        if (list.isEmpty) {
          return const NotFoundWidget(
              text: 'no Data ', icon: Icons.no_accounts);
        }
        list.first.id;
        return ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) {
            final item = list[i];
            return Container(
              padding: const EdgeInsets.only(left: 15.0, top: 3.0, bottom: 3.0).r,
              decoration: BoxDecoration(
                  color: AppColorManager.f9,
                  borderRadius: BorderRadius.circular(12.0.r)),
              margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0).r,
              child: ListTile(
                onTap: () {
                  AppProvider.setCommittee = item;
                  Navigator.pushNamed(context, RouteName.committeePage,
                      arguments: item.id);
                },
                title: DrawableText(
                  matchParent: true,
                  text: item.name,
                  maxLines: 1,
                ),
                subtitle: DrawableText(
                  matchParent: true,
                  text: item.description,
                  maxLines: 1,
                  color: Colors.grey,
                ),
                trailing: ImageMultiType(
                  url: Icons.arrow_forward_ios,
                  height: 17.0.r,
                  width: 17.0.r,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

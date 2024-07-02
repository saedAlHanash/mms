import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/features/home/ui/widget/hi_widget.dart';

import '../../../../router/app_router.dart';
import '../../bloc/my_committees_cubit/my_committees_cubit.dart';

class CommitteeScreen extends StatelessWidget {
  const CommitteeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HiWidget(),
        Expanded(
          child: BlocBuilder<MyCommitteesCubit, MyCommitteesInitial>(
            builder: (context, state) {
              final list = state.result;
              return RefreshWidget(
                onRefresh: () {
                  context
                      .read<MyCommitteesCubit>()
                      .getMyCommittees(newData: true);
                },
                statuses: state.statuses,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final item = list[i];
                    return InkWell(
                      onTap: () {
                        AppProvider.setCommittee = item;
                        Navigator.pushNamed(context, RouteName.committeePage,
                            arguments: item.id);
                      },
                      child: MyCardWidget(
                        elevation: 3.0.r,
                        padding: const EdgeInsets.all(5.0).r,
                        margin: const EdgeInsets.symmetric(
                                vertical: 7.0, horizontal: 20.0)
                            .r,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DrawableText(
                              text: item.name,
                              matchParent:true,
                              maxLines: 2,
                              size: 14.0.sp,
                              textAlign: TextAlign.center,
                            ),
                            DrawableText(
                              drawablePadding: 10.0.w,
                              text: item.member.membershipType.name,
                              maxLines: 1,
                              color: item.member.membershipType.getColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

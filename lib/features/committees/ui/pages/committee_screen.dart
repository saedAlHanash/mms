import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/membership_badge.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/committees/bloc/my_committees_cubit/my_committees_cubit.dart';
import 'package:mms/features/committees/data/response/committees_response.dart';
import 'package:mms/features/home/ui/widget/bottom_nav_widget.dart';
import 'package:mms/features/home/ui/widget/hi_widget.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/app_router.dart';

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
              final showSkeleton = state.loading && list.isEmpty;

              final Widget body;
              if (showSkeleton) {
                body = _grid(itemCount: 6, builder: (_) => const _CommitteeSkeleton());
              } else if (state.isDataEmpty) {
                body = ListView(
                  padding: EdgeInsets.only(top: 80.0.h, bottom: homeNavBarSpace),
                  children: [
                    EmptyStateWidget.large(
                      icon: Icons.groups_outlined,
                      title: S.of(context).iAmNotCurrentlyAMemberOfAnyCommittees,
                      description: S.of(context).noCommitteesDescription,
                    ),
                  ],
                );
              } else {
                body = _grid(
                  itemCount: list.length,
                  builder: (i) => _CommitteeCard(item: list[i]),
                );
              }

              return Column(
                children: [
                  if (!state.isDataEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0.w, 16.0.h, 20.0.w, 8.0.h),
                      child: DrawableText(
                        text: S.of(context).navCommittees,
                        size: 22.0.sp,
                        fontWeight: .w700,
                        color: AppColorManager.neutral900,
                        matchParent: true,
                        drawableEnd: list.isEmpty
                            ? null
                            : DrawableText(
                                text: S.of(context).committeesCount(list.length),
                                size: 13.0.sp,
                                color: AppColorManager.neutral500,
                              ),
                      ),
                    ),
                  Expanded(
                    child: RefreshWidget(
                      onRefresh: () {
                        context.read<MyCommitteesCubit>().getData(newData: true);
                      },
                      isLoading: state.loading,
                      child: body,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _grid({required int itemCount, required Widget Function(int i) builder}) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(20.0.w, 4.0.h, 20.0.w, homeNavBarSpace),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0.w,
        mainAxisSpacing: 12.0.h,
        mainAxisExtent: 158.0.h,
      ),
      itemCount: itemCount,
      itemBuilder: (_, i) => builder(i),
    );
  }
}

/// First letters of the first two words of the committee name.
String _initials(String name) {
  final words = name.trim().split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
  // Skip a generic leading word such as "لجنة" / "Committee" when there are more words.
  if (words.length > 2 && (words.first == 'لجنة' || words.first.toLowerCase() == 'committee')) {
    words.removeAt(0);
  }
  return words.take(2).map((e) => e.characters.first).join(' ');
}

class _CommitteeCard extends StatelessWidget {
  const _CommitteeCard({required this.item});

  final Committee item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColorManager.neutral0,
      borderRadius: BorderRadius.circular(12.0.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0.r),
        onTap: () {
          AppProvider.setCommittee = item;
          Navigator.pushNamed(context, RouteName.committeePage, arguments: item.id);
        },
        child: Ink(
          padding: EdgeInsets.all(14.0.r),
          decoration: BoxDecoration(
            border: Border.all(color: AppColorManager.neutral100),
            borderRadius: BorderRadius.circular(12.0.r),
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Container(
                width: 40.0.r,
                height: 40.0.r,
                alignment: .center,
                decoration: BoxDecoration(
                  color: AppColorManager.primary50,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: DrawableText(
                  text: _initials(item.name),
                  size: 14.0.sp,
                  fontWeight: .w700,
                  color: AppColorManager.primary700,
                  maxLines: 1,
                ),
              ),
              10.0.verticalSpace,
              DrawableText(
                text: item.name,
                size: 15.0.sp,
                fontWeight: .w700,
                color: AppColorManager.neutral900,
                maxLines: 2,
              ),
              const Spacer(),
              MembershipBadge(type: item.member.membershipType),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommitteeSkeleton extends StatelessWidget {
  const _CommitteeSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.0.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppColorManager.neutral50),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          SkeletonBox(width: 40.0.r, height: 40, radius: 10),
          10.0.verticalSpace,
          const FractionallySizedBox(widthFactor: 0.9, child: SkeletonBox(height: 14, radius: 6)),
          8.0.verticalSpace,
          const FractionallySizedBox(widthFactor: 0.6, child: SkeletonBox(height: 14, radius: 6)),
          const Spacer(),
          SkeletonBox(width: 48.0.w, height: 20, radius: 999),
        ],
      ),
    );
  }
}

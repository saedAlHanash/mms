import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/empty_state_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/core/widgets/small_widgets.dart';
import 'package:mms/features/circulation/bloc/circulations_cubit/circulations_cubit.dart';
import 'package:mms/features/circulation/ui/widgets/circulation_widgets.dart';
import 'package:mms/generated/l10n.dart';
import 'package:mms/router/go_router.dart';

/// A committee's decisions by circulation, open ones first.
class CirculationsPage extends StatelessWidget {
  const CirculationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CirculationsCubit>();

    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).circulations),
      body: Column(
        children: [
          const _Filters(),
          Expanded(
            child: BlocBuilder<CirculationsCubit, CirculationsInitial>(
              builder: (context, state) {
                final list = state.result;
                final Widget body;

                if (state.loading && list.isEmpty) {
                  body = ListView.separated(
                    padding: EdgeInsets.fromLTRB(20.0.w, 8.0.h, 20.0.w, 32.0.h),
                    itemCount: 4,
                    separatorBuilder: (_, _) => 12.0.verticalSpace,
                    itemBuilder: (_, _) => const SkeletonBox(height: 140, radius: 14),
                  );
                } else if (list.isEmpty) {
                  body = ListView(
                    padding: EdgeInsets.only(top: 80.0.h),
                    children: [
                      EmptyStateWidget.large(
                        icon: Icons.how_to_vote_outlined,
                        title: S.of(context).noCirculations,
                        description: S.of(context).noCirculationsDescription,
                      ),
                    ],
                  );
                } else {
                  body = NotificationListener<ScrollNotification>(
                    onNotification: (n) {
                      if (n.metrics.extentAfter < 300) cubit.loadMore();
                      return false;
                    },
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(20.0.w, 8.0.h, 20.0.w, 32.0.h),
                      itemCount: list.length + (state.hasMore ? 1 : 0),
                      separatorBuilder: (_, _) => 12.0.verticalSpace,
                      itemBuilder: (context, i) {
                        if (i == list.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0.h),
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2, color: AppColorManager.primary500),
                            ),
                          );
                        }
                        return CirculationCard(
                          item: list[i],
                          onTap: () async {
                            await context.pushNamed(
                              RouteName.circulation,
                              queryParameters: {RouteParam.id: list[i].id},
                            );
                            // A vote may have changed it.
                            cubit.getData();
                          },
                        );
                      },
                    ),
                  );
                }

                return RefreshWidget(isLoading: state.loading, onRefresh: cubit.getData, child: body);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// All / Open / Closed / Withdrawn.
class _Filters extends StatelessWidget {
  const _Filters();

  @override
  Widget build(BuildContext context) {
    final options = <(CirculationStatus?, String)>[
      (null, S.of(context).all),
      (CirculationStatus.open, CirculationStatus.open.label),
      (CirculationStatus.closed, CirculationStatus.closed.label),
      (CirculationStatus.withdrawn, CirculationStatus.withdrawn.label),
    ];

    return BlocBuilder<CirculationsCubit, CirculationsInitial>(
      buildWhen: (p, c) => p.statusFilter != c.statusFilter,
      builder: (context, state) {
        return SizedBox(
          height: 56.0.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 6.0.h),
            itemCount: options.length,
            separatorBuilder: (_, _) => 8.0.horizontalSpace,
            itemBuilder: (context, i) {
              final (value, label) = options[i];
              final selected = state.statusFilter == value;
              return ChoiceChip(
                label: DrawableText(
                  text: label,
                  size: 13.0.sp,
                  fontWeight: .w600,
                  color: selected ? AppColorManager.neutral0 : AppColorManager.neutral700,
                ),
                selected: selected,
                showCheckmark: false,
                onSelected: (_) => context.read<CirculationsCubit>().setFilter(value),
                selectedColor: AppColorManager.primary500,
                backgroundColor: AppColorManager.neutral25,
                side: BorderSide(color: selected ? AppColorManager.primary500 : AppColorManager.neutral100),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                materialTapTargetSize: MaterialTapTargetSize.padded,
              );
            },
          ),
        );
      },
    );
  }
}

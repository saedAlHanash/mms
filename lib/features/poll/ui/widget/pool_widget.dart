import 'package:drawable_text/drawable_text.dart';

/// Package imports
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_checkbox_widget.dart';
import 'package:mms/features/poll/data/response/poll_response.dart';
import 'package:mms/features/vote/data/request/create_vote_request.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/my_card_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../vote/bloc/create_vote_cubit/create_vote_cubit.dart';

class PollWidget extends StatefulWidget {
  const PollWidget({super.key, required this.poll});

  final Poll poll;

  @override
  State<PollWidget> createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  var request = CreateVoteRequest();

  var enable = true;

  @override
  void initState() {
    request.pollId = widget.poll.id;
    enable = widget.poll.status == PollStatus.open;
    super.initState();
  }

  /// Returns the circular series with semi doughunut series.
  SfCircularChart _buildSemiDoughnutChart() {
    return SfCircularChart(
      palette: [
        AppColorManager.mainColor.withOpacity(1),
        AppColorManager.mainColor.withOpacity(.9),
        AppColorManager.mainColor.withOpacity(.7),
        AppColorManager.mainColor.withOpacity(.5),
        AppColorManager.mainColor.withOpacity(.3),
        AppColorManager.mainColor.withOpacity(.1),
      ],
      series: _getSemiDoughnutSeries(widget.poll.options),
      tooltipBehavior: TooltipBehavior(enable: true),
      margin: EdgeInsets.zero,
    );
  }

  /// Returns  semi doughnut series.
  List<PieSeries<Option, String>> _getSemiDoughnutSeries(
    List<Option> options,
  ) {
    return <PieSeries<Option, String>>[
      PieSeries(
        dataSource: options,
        xValueMapper: (Option data, _) => data.option,
        yValueMapper: (Option data, _) => data.voters.length,
        dataLabelMapper: (Option data, _) => data.option,
        startAngle: 270,
        endAngle: 90,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.poll.status == PollStatus.closed) {
      return MyCardWidget(
        child: Column(
          children: [
            DrawableText(
              text: widget.poll.topic,
              matchParent: true,
              size: 18.0.sp,
              textAlign: TextAlign.start,
              color: AppColorManager.mainColor,
            ),
            10.0.verticalSpace,
            for (var e in widget.poll.options)
              Container(
                width: 1.0.sw,
                height: 40.0.h,
                margin: const EdgeInsets.all(12.0).r,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0.r),
                        color: AppColorManager.mainColor.withOpacity(0.2),
                      ),
                      alignment: Alignment.center,
                      width: (e.voters.length / widget.poll.votersCount).sw,
                      height: 40.0.h,
                    ),
                    DrawableText(
                      text: e.option,
                      padding: const EdgeInsets.all(12.0).r,
                      drawablePadding: 10.0.w,
                      matchParent: true,
                      drawableEnd: DrawableText(text: '(${e.voters.length})'),
                      drawableStart: const ImageMultiType(
                        url: Assets.iconsRadioSelected,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    }
    return MyCardWidget(
      radios: 15.0.r,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0).r,
      child: Column(
        children: [
          DrawableText(
            text: widget.poll.topic,
            matchParent: true,
            size: 18.0.sp,
            textAlign: TextAlign.start,
            color: AppColorManager.mainColor,
          ),
          10.0.verticalSpace,
          MyCheckboxWidget(
            items: widget.poll
                .getSpinnerItems(selectedId: widget.poll.meOptionVote?.id),
            isRadio: true,
            onSelected: (value, i, isSelected) {
              setState(() {
                request.pollOptionId = value.item.id;
              });
            },
          ),
          DrawableText(
            text: '${S.of(context).voters}: ${widget.poll.votersCount}',
            matchParent: true,
            size: 18.0.sp,
            drawableEnd: BlocBuilder<CreateVoteCubit, CreateVoteInitial>(
              buildWhen: (p, c) => c.mRequest.pollId == widget.poll.id,
              builder: (context, state) {
                return MyButton(
                  onTap: () {
                    if (widget.poll.meOptionVote != null) {
                      request.id = widget.poll.meOptionVote!.voteId;
                    }

                    context
                        .read<CreateVoteCubit>()
                        .createVote(request: request);
                  },
                  enable: enable && !request.pollOptionId.isBlank,
                  width: 0.3.sw,
                  color: AppColorManager.mainColor,
                  loading: state.statuses.loading,
                  endIcon: const ImageMultiType(
                    url: Icons.done,
                    color: Colors.white,
                  ),
                  text: widget.poll.meOptionVote == null
                      ? S.of(context).vote
                      : S.of(context).editVote,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

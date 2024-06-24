import 'package:drawable_text/drawable_text.dart';

/// Package imports
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_checkbox_widget.dart';
import 'package:mms/features/poll/data/response/poll_response.dart';
import 'package:mms/features/vote/data/request/create_vote_request.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Local imports
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/my_card_widget.dart';
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
      centerX: '25%',
      series: _getSemiDoughnutSeries(widget.poll.options),
      tooltipBehavior: TooltipBehavior(enable: true),
      margin: EdgeInsets.zero,
    );
  }

  /// Returns  semi doughnut series.
  List<DoughnutSeries<Option, String>> _getSemiDoughnutSeries(
    List<Option> options,
  ) {
    return <DoughnutSeries<Option, String>>[
      DoughnutSeries(

        dataSource: options,
        innerRadius: '78%',
        radius: '50%',
        strokeColor: AppColorManager.whit,
        strokeWidth: 7.0.r,
        xValueMapper: (Option data, _) => data.option,
        yValueMapper: (Option data, _) => data.voters.length,
        dataLabelMapper: (Option data, _) => data.option,
        cornerStyle: CornerStyle.bothCurve,

      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (widget.poll.status == PollStatus.closed) {
      return MyCardWidget(
        child: _buildSemiDoughnutChart(),
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

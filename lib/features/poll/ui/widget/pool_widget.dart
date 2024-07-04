import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/my_button.dart';
import 'package:mms/core/widgets/my_checkbox_widget.dart';
import 'package:mms/features/poll/data/response/poll_response.dart';
import 'package:mms/features/vote/data/request/create_vote_request.dart';

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

  @override
  Widget build(BuildContext context) {
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
          ),
          10.0.verticalSpace,
          MyCheckboxWidget(
            items: widget.poll
                .getSpinnerItems(selectedId: widget.poll.meOptionVote?.id),
            isRadio: true,
            buttonBuilder: (selected, value, context) {
              return Container(
                width: 1.0.sw,
                height: 40.0.h,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColorManager.mainColor.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0.sp),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
                // margin: const EdgeInsets.symmetric(vertical:2 ).r,
                child: DrawableText(
                  text: value.name ?? '',
                  drawablePadding: 5.0.w,
                  fontFamily: FontManager.cairoBold.name,
                  drawableStart: ImageMultiType(
                    url: selected
                        ? Icons.check_box_outlined
                        : Icons.check_box_outline_blank,
                    color: selected
                        ? AppColorManager.mainColor
                        : AppColorManager.grey,
                  ),
                ),
              );
            },
            onSelected: (value, i, isSelected) {
              setState(() {
                request.pollOptionId = value.item.id;
              });
            },
          ),
          10.0.verticalSpace,
          DrawableText(
            text: '${S.of(context).voters}: ${widget.poll.votersCount}',
            matchParent: true,
            size: 18.0.sp,
            drawableEnd: BlocBuilder<CreateVoteCubit, CreateVoteInitial>(
              buildWhen: (p, c) => c.mRequest.pollId == widget.poll.id,
              builder: (context, state) {
                if (!enable ||
                    request.pollOptionId == widget.poll.meOptionVote?.id) {
                  return 0.0.verticalSpace;
                }
                return MyButton(
                  onTap: () {
                    if (widget.poll.meOptionVote != null) {
                      request.id = widget.poll.meOptionVote!.voteId;
                    }

                    context
                        .read<CreateVoteCubit>()
                        .createVote(request: request);
                  },
                  width: 0.4.sw,
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

class PollResultWidget extends StatelessWidget {
  const PollResultWidget({super.key, required this.pollResult});

  final PollResult pollResult;

  @override
  Widget build(BuildContext context) {
    return MyCardWidget(
      child: Column(
        children: [
          DrawableText(
            text: pollResult.topic,
            matchParent: true,
            size: 18.0.sp,
            textAlign: TextAlign.start,
            color: AppColorManager.mainColor,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 0.22.sh,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          centerSpaceRadius: 70.0.r,
                          sections: pollResult.voteResults.mapIndexed(
                            (i, e) {
                              return PieChartSectionData(
                                color: AppColorManager.getPollColor(i),
                                value:
                                    e.voteCount * 100 / (pollResult.totalVotes),
                                title: '',
                                radius: 15.0.r,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      DrawableText(
                          fontFamily: FontManager.cairoBold.name,
                          size: 20.0.sp,
                          text:
                              '${pollResult.votersCount} ${S.of(context).votes}'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: pollResult.voteResults
                      .mapIndexed(
                        (i, e) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 3.0).h,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3.0).r,
                          decoration: BoxDecoration(
                            color: AppColorManager.cardColor,
                            borderRadius: BorderRadius.circular(8.0.sp),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 25.0.r,
                                width: 25.0.r,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFE5D8FB),
                                ),
                                child: ImageMultiType(
                                  height: 12.0.r,
                                  width: 12.0.r,
                                  url: Icons.circle,
                                  color: AppColorManager.getPollColor(i),
                                ),
                              ),
                              10.0.horizontalSpace,
                              Expanded(
                                child: DrawableText(
                                  text: e.option ?? '',
                                  color: AppColorManager.getPollColor(i),
                                  padding: const EdgeInsets.symmetric(vertical: 5.0).r,
                                  fontFamily: FontManager.cairoBold.name,
                                ),
                              ),
                              DrawableText(
                                text: e.voteCount.toString() ?? '',
                                size: 22.0.sp,
                                color: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 5.0).r,
                                fontFamily: FontManager.cairoBold.name,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

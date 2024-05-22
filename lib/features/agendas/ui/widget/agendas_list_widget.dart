import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../router/app_router.dart';
import '../../data/response/agendas_response.dart';

class AgendaListWidget extends StatelessWidget {
  const AgendaListWidget({super.key, required this.agendas});

  final List<Agenda> agendas;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: agendas
          .map(
            (e) => AgendaWidget(
              agenda: e,
              onTap: () =>
                  Navigator.pushNamed(context, RouteName.agenda, arguments: e),
            ),
          )
          .toList(),
    );
  }
}

class AgendaWidget extends StatelessWidget {
  const AgendaWidget({super.key, required this.agenda, this.onTap});

  final Agenda agenda;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorManager.f9,
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: ListTile(
        onTap: onTap,
        title: DrawableText(
          text: agenda.title,
          fontFamily: FontManager.cairoBold.name,
        ),
        subtitle: DrawableText(text: agenda.description, color: Colors.grey),
        trailing: ImageMultiType(
          url: Icons.arrow_forward_ios,
          height: 17.0.r,
          width: 17.0.r,
        ),
      ),
    );
  }
}

class _CommentsWidget extends StatelessWidget {
  const _CommentsWidget({required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsetsDirectional.only(start: 30.0.w, bottom: 10.0.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: AppColorManager.f9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 0.6.sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawableText(
                  text: comment.text,
                  fontFamily: FontManager.cairoBold.name,
                  size: 20.0.sp,
                  maxLines: 2,
                ),
                10.0.verticalSpace,
                DrawableText(
                  text: comment.date?.formatDateTime ?? '',
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DrawableText(
                drawableEnd: ImageMultiType(
                  url: Icons.not_started_rounded,
                  height: 17.0.r,
                  width: 17.0.r,
                  color: Colors.green,
                ),
                drawablePadding: 10.0.w,
                text: comment.party.name,
              ),
              20.0.verticalSpace,
              DrawableText(
                drawableEnd: ImageMultiType(
                  url: Icons.edit_calendar,
                  color: Colors.amber,
                  height: 17.0.r,
                  width: 17.0.r,
                ),
                drawablePadding: 10.0.w,
                text: comment.party.company,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

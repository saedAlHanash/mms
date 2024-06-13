import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/util/my_style.dart';
import 'package:mms/core/widgets/my_expansion/item_expansion.dart';
import 'package:mms/core/widgets/my_expansion/my_expansion_panal.dart';
import 'package:mms/core/widgets/my_expansion/my_expansion_widget.dart';
import 'package:mms/features/meetings/bloc/meeting_cubit/meeting_cubit.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../router/app_router.dart';
import '../../data/response/agendas_response.dart';

class AgendaListWidget extends StatelessWidget {
  const AgendaListWidget({super.key, required this.agendas});

  final List<Agenda> agendas;

  @override
  Widget build(BuildContext context) {
    if (agendas.isEmpty) return 0.0.verticalSpace;
    return MyExpansionWidget(
      decoration: MyStyle.roundBox,
      items: [
        ItemExpansion(
            body: Column(
              children: [
                ...agendas.map((e) {
                  return AgendaWidget(
                    agenda: e,
                    onTap: () {
                      return Navigator.pushNamed(
                        context,
                        RouteName.agenda,
                        arguments: [e, context.read<MeetingCubit>()],
                      );
                    },
                  );
                }),
              ],
            ),
            header: DrawableText(
              text: 'Agendas (${agendas.length})',
              size: 20.0.sp,
              matchParent: true,
              fontWeight: FontWeight.bold,
              fontFamily: FontManager.cairoBold.name,
              padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
            )),
      ],
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
      margin: const EdgeInsets.symmetric(vertical: 10.0).h,
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

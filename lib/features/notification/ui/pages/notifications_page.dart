import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/notifications_cubit/notifications_cubit.dart';
import '../widget/notification_widget.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBarWidget(titleText: S.of(context).notifications),
        body: BlocBuilder<NotificationsCubit, NotificationsInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<NotificationsCubit>()
                    .getNotifications(newData: true);
              },
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 200.0),
                itemCount: state.result.length,
                itemBuilder: (context, i) {
                  return NotificationWidget(item: state.result[i]);
                },
              ),
            );
          },
        ));
  }
}

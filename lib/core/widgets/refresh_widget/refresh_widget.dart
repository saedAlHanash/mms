import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/strings/enum_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget({
    super.key,
    required this.child,
    this.onRefresh,
    required this.statuses,
  });

  final Widget child;
  final Function()? onRefresh;
  final CubitStatuses statuses;

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  final _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    widget.onRefresh?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.statuses.done) {
      _refreshController.refreshCompleted();
    } else if (widget.statuses.loading) {
      _refreshController.loadComplete();
    }
    return SmartRefresher(
      enablePullDown: true,
      header: const WaterDropHeader(waterDropColor: AppColorManager.mainColor,),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: widget.child,
    );
  }
}

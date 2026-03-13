import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget({
    super.key,
    required this.child,
    this.onRefresh,
    required this.isLoading,
    this.padding,
  });

  final Widget child;
  final Function()? onRefresh;
  final bool isLoading;
  final EdgeInsets? padding;

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
    if (!widget.isLoading) {
      _refreshController.refreshCompleted();
    } else {
      Future(() => _refreshController.requestRefresh(needCallback: false));
    }
    var d = bool.hasEnvironment('');
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(
          waterDropColor: AppColorManager.mainColor,
          refresh: SizedBox(
            height: 15.0.r,
            width: 15.0.r,
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(AppColorManager.mainColor),
            ),
          ),
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: widget.child,
      ),
    );
  }
}

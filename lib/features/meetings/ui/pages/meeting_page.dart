import 'dart:io';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/api_manager/api_service.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/extensions/extensions.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/app_bar/app_bar_widget.dart';
import 'package:mms/core/widgets/my_card_widget.dart';
import 'package:mms/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:mms/features/agendas/ui/widget/agenda_tree_widget.dart';
import 'package:mms/features/attendees/ui/widget/attendees_list_widget.dart';
import 'package:mms/features/committees/ui/widget/drawer_btn_widget.dart';
import 'package:mms/features/live_kit/ui/pages/live_kit_page.dart';
import 'package:mms/features/meetings/ui/widget/discussions_tree.dart';
import 'package:native_plugin/native_plugin.dart';
import 'package:pip/pip.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/app_router.dart';
import '../../bloc/add_absence_cubit/add_absence_cubit.dart';
import '../../bloc/meeting_cubit/meeting_cubit.dart';

class MeetingPage extends StatefulWidget {
  const MeetingPage({super.key});

  @override
  State<MeetingPage> createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> with WidgetsBindingObserver {
  final _pip = Pip();
  final _formKey = GlobalKey<FormState>();

  bool _isPipSupported = false;
  bool _isPipAutoEnterSupported = false;
  bool _isPipActive = false;
  final int _playerView = 0;
  int _pipContentView = 0;

  bool _autoEnterEnabled = false;

  final _nativePlugin = NativePlugin();

  AppLifecycleState _lastAppLifecycleState = AppLifecycleState.resumed;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    try {
      await _nativePlugin.getPlatformVersion();
      _isPipSupported = await _pip.isSupported();
      _isPipAutoEnterSupported = await _pip.isAutoEnterSupported();
      _isPipActive = await _pip.isActived();
      await _pip.registerStateChangedObserver(PipStateChangedObserver(
        onPipStateChanged: (state, error) {
          setState(() {
            _isPipActive = state == PipState.pipStateStarted;
          });

          if (state == PipState.pipStateFailed) {
            _pip.dispose();
          }
        },
      ));
    } on PlatformException {
      _isPipSupported = false;
      _isPipAutoEnterSupported = false;
      _isPipActive = false;
    }
    _autoEnterEnabled = true;
    setState(() {});
    await _setupPip();
    setState(() {});
  }

  Future<void> _setupPip() async {
    if (Platform.isIOS && _pipContentView == 0) {
      _pipContentView = await _nativePlugin.createPipContentView();
    }

    final options = PipOptions(
      autoEnterEnabled: _autoEnterEnabled,
      seamlessResizeEnabled: true,
      useExternalStateMonitor: true,
      externalStateMonitorInterval: 100,
      // ios only
      contentView: _pipContentView,
      sourceContentView: _playerView,
      controlStyle: 2,
    );

    try {
      await _pip.setup(options);
    } catch (_) {}
  }

  @override
  void dispose() {
    if (Platform.isIOS && _pipContentView != 0) {
      _nativePlugin.disposePipContentView(_pipContentView);
    }

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive) {
      if (_lastAppLifecycleState != AppLifecycleState.paused && !_isPipAutoEnterSupported) {
        await _pip.start();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!Platform.isAndroid) await _pip.stop();
    }

    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_lastAppLifecycleState != state) {
          setState(() {
            _lastAppLifecycleState = state;
          });
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MeetingCubit, MeetingInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            AppProvider.setMeeting = state.result;
          },
        ),
        BlocListener<AddAbsenceCubit, AddAbsenceInitial>(
          listenWhen: (p, c) => c.statuses.done,
          listener: (context, state) {
            context.read<MeetingCubit>().getData(newData: true);
          },
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          loggerObject.w('$result $didPop');
          // return;
          if (!_isPipSupported) return;
          final success = _pip.start();
        },
        child: Scaffold(
          appBar: AppBarWidget(
            titleText: S.of(context).meeting,
            actions: const [
              ActionBarMemberWidget(),
            ],
          ),
          endDrawer: Drawer(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            child: BlocBuilder<MeetingCubit, MeetingInitial>(
              builder: (context, state) {
                return AttendeesListWidget(meeting: state.result);
              },
            ),
          ),
          body: BlocBuilder<MeetingCubit, MeetingInitial>(
            builder: (context, state) {
              final item = state.result;
              return RefreshWidget(
                onRefresh: () => context.read<MeetingCubit>().getData(newData: true),
                isLoading: state.loading,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCardWidget(
                        radios: 15.0.r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DrawableText(
                              matchParent: true,
                              fontWeight: FontWeight.bold,
                              size: 20.0.sp,
                              text: item.title,
                            ),
                            5.0.verticalSpace,
                            DrawableText(
                              text: item.meetingPlace,
                              drawableStart: ImageMultiType(
                                url: Icons.place,
                                height: 15.0.r,
                                width: 15.0.r,
                              ),
                            ),
                            10.0.verticalSpace,
                            Row(
                              children: [
                                DrawableText(
                                  drawableStart: ImageMultiType(
                                    url: Icons.not_started_rounded,
                                    height: 24.0.r,
                                    width: 24.0.r,
                                    color: Colors.green,
                                  ),
                                  drawablePadding: 10.0.w,
                                  text: item.fromDate?.formatDateTime ?? '',
                                ),
                                const Spacer(),
                                DrawableText(
                                  drawableStart: ImageMultiType(
                                    url: Icons.edit_calendar,
                                    color: Colors.black,
                                    height: 24.0.r,
                                    width: 24.0.r,
                                  ),
                                  drawablePadding: 10.0.w,
                                  text: item.toDate?.formatDateTime ?? '',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // const AbsentWidget(),
                      20.0.verticalSpace,
                      ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0.r)),
                        tileColor: AppColorManager.mainColor.withValues(alpha: 0.2),
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.votes, arguments: context.read<MeetingCubit>());
                        },
                        title: DrawableText(
                          text: S.of(context).votes,
                          size: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        trailing: state.result.countPollsNotVotes == 0
                            ? ImageMultiType(url: Icons.arrow_forward_ios, color: Colors.grey, width: 17.0.sp)
                            : Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    padding: const EdgeInsets.all(7.0).r,
                                    child: DrawableText(
                                      text: state.result.countPollsNotVotes.toString(),
                                      color: Colors.white,
                                    ),
                                  ),
                                  5.0.horizontalSpace,
                                  ImageMultiType(url: Icons.arrow_forward_ios, color: Colors.grey, width: 17.0.sp)
                                ],
                              ),
                        leading: ImageMultiType(url: Icons.how_to_vote),
                      ),
                      20.0.verticalSpace,
                      AgendaTreeWidget(
                        treeNode: state.getAgendaTree(),
                      ),
                      20.0.verticalSpace,
                      if (state.result.discussions.isNotEmpty) DiscussionsTree(treeNode: state.getDiscussionTree()),
                      100.0.verticalSpace,
                      // GoalListWidget(goals: item.goals),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _VideoCall extends StatefulWidget {
  const _VideoCall({super.key});

  @override
  State<_VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<_VideoCall> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingCubit, MeetingInitial>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isOpen = !isOpen;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)).r,
                  color: AppColorManager.cardColor,
                ),
                child: DrawableText(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0).r,
                  text: 'Online Meeting',
                  matchParent: true,
                  drawableEnd: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      isOpen ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                    ),
                  ),
                ),
              ),
            ),
            LiveKitPage(
              isOpen: isOpen,
              link: state.result.onlineMeetingUrl,
              token: state.result.onlineMeetingToken,
            ),
          ],
        );
      },
    );
  }
}

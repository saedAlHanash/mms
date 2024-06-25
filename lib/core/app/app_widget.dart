import 'package:drawable_text/drawable_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/app/app_provider.dart';
import 'package:mms/core/strings/app_color_manager.dart';

import '../../features/auth/bloc/get_me_cubit/get_me_cubit.dart';
import '../../features/committees/bloc/my_committees_cubit/my_committees_cubit.dart';
import '../../features/meetings/bloc/meetings_cubit/meetings_cubit.dart';
import '../../features/notification/bloc/notifications_cubit/notifications_cubit.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../main.dart';
import '../../router/app_router.dart';
import '../api_manager/request_models/command.dart';
import '../app_theme.dart';
import '../injection/injection_container.dart';
import '../util/shared_preferences.dart';
import 'bloc/loading_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<void> setLocale(BuildContext context, String langCode) async {
    await AppSharedPreference.cashLocal(langCode);
    if (context.mounted) {
      final state = context.findAncestorStateOfType<_MyAppState>();
      await state?.setLocale(
          Locale.fromSubtags(languageCode: AppSharedPreference.getLocal));
    }
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    S.load(Locale(AppSharedPreference.getLocal));
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      String title = '';
      String body = '';

      if (notification != null) {
        title = notification.title ?? '';
        body = notification.body ?? '';
      } else {
        title = message.data['title'] ?? '';
        body = message.data['body'] ?? '';
      }

      Note.showBigTextNotification(title: title, body: body);
    });
    setImageMultiTypeErrorImage(
      const Opacity(
        opacity: 0.3,
        child: ImageMultiType(
          url: Assets.iconsLogo,
          height: 30.0,
          width: 30.0,
        ),
      ),
    );
    super.initState();
  }

  Future<void> setLocale(Locale locale) async {
    AppSharedPreference.cashLocal(locale.languageCode);
    await S.load(locale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final loading = Builder(builder: (_) {
      return Visibility(
        visible: context.watch<LoadingCubit>().state.isLoading,
        child: SafeArea(
          child: Column(
            children: [
              const LinearProgressIndicator(),
              Expanded(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return ScreenUtilInit(
      // designSize: const Size(375, 812*3),
      designSize: Size(MediaQuery.of(context).size.width * 1.3,
          MediaQuery.of(context).size.height),
      // designSize: const Size(14440, 972),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) {
        DrawableText.initial(
          headerSizeText: 20.0.sp,
          initialHeightText: 1.5.sp,
          titleSizeText: 18.0.sp,
          initialSize: 16.0.sp,
          selectable: false,
          initialColor: AppColorManager.black,
        );

        return MaterialApp(
          navigatorKey: sl<GlobalKey<NavigatorState>>(),
          locale:
              Locale.fromSubtags(languageCode: AppSharedPreference.getLocal),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (_, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => sl<NotificationsCubit>()..getNotifications(),
                ),
                BlocProvider(
                  create: (_) => sl<MyCommitteesCubit>()..getMyCommittees(),
                ),
                BlocProvider(
                  create: (_) {
                    return sl<MeetingsCubit>()
                      ..getMeetings(
                        request:
                            FilterRequest(partyId: AppProvider.getParty.id),
                      );
                  },
                ),
                BlocProvider(
                  create: (_) => sl<LoggedPartyCubit>()..getLoggedParty(),
                ),
              ],
              child: GestureDetector(
                onTap: () {
                  final currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: Stack(
                  children: [child!, loading],
                ),
              ),
            );
          },
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          onGenerateRoute: routes,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

BuildContext? get ctx => sl<GlobalKey<NavigatorState>>().currentContext;

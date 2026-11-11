import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../app/app_provider.dart';
import '../strings/app_color_manager.dart';

class MyStyle {
  //region number style

  static final double cardRadios = 0.0.r;

  //endregion

//region margin/padding
  static final cardPadding = EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h);

  static final pagePadding = EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h);

//endregion

  //region redesign tokens

  //region spacing
  static final double space4 = 4.0.r;
  static final double space8 = 8.0.r;
  static final double space12 = 12.0.r;
  static final double space16 = 16.0.r;
  static final double space20 = 20.0.r;
  static final double space24 = 24.0.r;
  static final double space32 = 32.0.r;
  static final double space40 = 40.0.r;
  //endregion

  //region radius
  static final double radiusSm = 8.0.r;
  static final double radiusMd = 12.0.r;
  static final double radiusLg = 16.0.r;
  static final double radiusXl = 24.0.r;
  static const double radiusPill = 999.0;
  //endregion

  //region shadows
  static const elevation1 = [
    BoxShadow(color: Color(0x0F1D1922), blurRadius: 2, offset: Offset(0, 1)),
    BoxShadow(color: Color(0x0F1D1922), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const elevation2 = [
    BoxShadow(color: Color(0x1F1D1922), blurRadius: 24, offset: Offset(0, 8)),
  ];

  /// Upward shadow for bottom-anchored panels.
  static const elevationTop = [
    BoxShadow(color: Color(0x2E1D1922), blurRadius: 24, offset: Offset(0, -8)),
  ];
  //endregion

  //region text styles (font size / line height / weight)
  static TextStyle _text(double size, double lineHeight, FontWeight weight) => TextStyle(
        fontSize: size.sp,
        height: lineHeight / size,
        fontWeight: weight,
      );

  static final headlineLg = _text(24, 36, FontWeight.w700);
  static final headlineMd = _text(20, 32, FontWeight.w700);
  static final appBarTitle = _text(18, 26, FontWeight.w700);
  static final title = _text(17, 28, FontWeight.w600);
  static final bodyLg = _text(16, 26, FontWeight.w400);
  static final bodyMd = _text(14, 22, FontWeight.w400);
  static final label = _text(14, 20, FontWeight.w600);
  static final caption = _text(12, 18, FontWeight.w500);
  static final button = _text(16, 24, FontWeight.w700);
  //endregion

  //endregion

  static const underLineStyle = TextStyle(fontStyle: FontStyle.italic, decoration: TextDecoration.underline);

  static var drawerShape = ShapeDecoration(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: AppColorManager.mainColor.withValues(alpha: 0.9));

  static var normalShadow = [
    BoxShadow(color: AppColorManager.grey.withValues(alpha: 0.6), blurRadius: 15, offset: const Offset(0, 5))
  ];

  static var lightShadow = [
    BoxShadow(color: AppColorManager.grey.withValues(alpha: 0.5), blurRadius: 5, offset: const Offset(0, 2))
  ];

  static var allShadow = [
    BoxShadow(
      color: AppColorManager.grey.withValues(alpha: 0.5),
      blurRadius: 10,
    )
  ];
  static var allShadowDark = [
    BoxShadow(
      color: AppColorManager.grey.withValues(alpha: 0.6),
      blurRadius: 10.spMin,
    )
  ];

  static final formBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColorManager.offWhit.withValues(alpha: 0.27),
      ),
      borderRadius: BorderRadius.circular(10.0.r));

  static final hintStyle = TextStyle(
    fontSize: 18.0.spMin,
    color: AppColorManager.grey.withValues(alpha: 0.6),
  );
  static final textFormTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18.0.spMin,
    color: Colors.black87,
  );

  static var roundBox = BoxDecoration(
    color: AppColorManager.cardColor,
    borderRadius: BorderRadius.circular(8.0.r),
  );

  static var roundBoxGray = BoxDecoration(
    color: AppColorManager.offWhit,
    borderRadius: BorderRadius.circular(6.0.r),
  );

  static var roundBox12 = BoxDecoration(
    color: AppColorManager.whit,
    borderRadius: BorderRadius.circular(12.0.r),
    boxShadow: MyStyle.allShadowDark,
  );

  static BoxDecoration get directionalDecoration => BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: AppProvider.arabic ? Radius.zero : Radius.circular(10.0.r),
          right: !AppProvider.arabic ? Radius.zero : Radius.circular(10.0.r),
        ),
        color: AppColorManager.mainColor,
      );

  static Widget loadingWidget({Color? color, double? size}) {
    final p = Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: color,
          valueColor: AlwaysStoppedAnimation<Color>(isColorDark(color) ? Colors.white : AppColorManager.mainColor),
        ),
      ),
    );
    return size == null ? p : SizedBox(width: size, height: size, child: p);
  }

  static var outlineBorder = BoxDecoration(
    border: Border.all(color: Colors.green),
    borderRadius: BorderRadius.circular(12.0.r),
    color: AppColorManager.lightGray,
  );

  static var lightShadowMainColor = [
    BoxShadow(color: AppColorManager.mainColor.withValues(alpha: 0.2), blurRadius: 5, offset: const Offset(0, 2))
  ];

  static final appBorderAll = Border.all(
    strokeAlign: BorderSide.strokeAlignOutside,
    color: AppColorManager.mainColor,
    width: 2.0.spMin,
  );

  static final authPagesPadding = EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h);

  static final productGridDelegate =
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250.0.h);
}

class BackBtnWidget extends StatelessWidget {
  const BackBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 44×44 touch area; the chevron mirrors automatically in RTL.
    return Center(
      child: SizedBox(
        width: 44.0.r,
        height: 44.0.r,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          icon: ImageMultiType(
            url: Icons.arrow_back_ios_new,
            width: 22.0.r,
            height: 22.0.r,
            color: AppColorManager.neutral900,
          ),
        ),
      ),
    );
  }
}

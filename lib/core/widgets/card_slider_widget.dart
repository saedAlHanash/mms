import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:mms/core/strings/app_color_manager.dart';
import 'package:mms/core/widgets/my_card_widget.dart';

class CardSlider extends StatelessWidget {
  const CardSlider({
    Key? key,
    this.margin,
    this.stackChild,
    required this.images,
    this.height,
    this.width,
  }) : super(key: key);

  final EdgeInsets? margin;
  final List<Widget>? stackChild;
  final List<String> images;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    final key = GlobalKey<IndicatorSliderWidgetState>();
    widgets.add(
      SizedBox.expand(
        child: CarouselSlider(
          items: images.map(
            (e) {
              return ImageMultiType(
                url: e,
                width: width ?? 1.0.sw,
                fit: BoxFit.fill,
                height: 1.0.sh,
              );
            },
          ).toList(),
          options: CarouselOptions(
            enableInfiniteScroll: false,
            autoPlayInterval: const Duration(seconds: 10),
            // autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (i, reason) {
              key.currentState!.changePage(i);
            },
          ),
        ),
      ),
    );

    if (stackChild != null) {
      widgets.add(
        IgnorePointer(
          child: Container(
            height: 1.0.sh,
            width: width ?? 1.0.sw,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.01),
                  Colors.black.withOpacity(0.01),
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
          ),
        ),
      );
      for (var e in stackChild!) {
        widgets.add(e);
      }
    }
    widgets.add(Positioned(
      bottom: 7.0.h,
      left: 30.0.w,
      child: IndicatorSliderWidget(key: key, length: images.length),
    ));
    return MyCardWidget(
      padding: EdgeInsets.zero,
      margin: margin,
      radios: 16.0.r,
      elevation: 0.0,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: widgets,
        ),
      ),
    );
  }
}

class CardImageSlider extends StatefulWidget {
  const CardImageSlider({
    Key? key,
    this.margin,
    this.stackChild,
    required this.images,
    this.height,
    this.width,
    this.card = false,
  }) : super(key: key);

  final EdgeInsets? margin;
  final List<Widget>? stackChild;
  final List<String> images;
  final double? height;
  final double? width;
  final bool card;

  @override
  State<CardImageSlider> createState() => _CardImageSliderState();
}

class _CardImageSliderState extends State<CardImageSlider> {
  late final CarouselController controller;

  late int currentImage;

  @override
  void initState() {
    controller = CarouselController();
    currentImage = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    final key = GlobalKey<IndicatorSliderWidgetState>();
    widgets.add(
      CarouselSlider(
        carouselController: controller,
        items: widget.images.map(
          (e) {
            return ImageMultiType(
              url: e,
              width: widget.width ?? 1.0.sw,
              height: 1.0.sh,
              fit: BoxFit.cover,
            );
          },
        ).toList(),
        options: CarouselOptions(
          autoPlayInterval: const Duration(seconds: 10),
          height: widget.height,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          onPageChanged: (i, reason) {
            key.currentState!.changePage(i);
            currentImage = i;
          },
        ),
      ),
    );

    if (widget.stackChild != null) {
      widgets.add(
        IgnorePointer(
          child: Container(
            height: 1.0.sh,
            width: widget.width ?? 1.0.sw,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.01),
                  Colors.black.withOpacity(0.01),
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
          ),
        ),
      );
      for (var e in widget.stackChild!) {
        widgets.add(e);
      }
    }
    widgets.add(
      Positioned(
        bottom: 29.0.h,
        left: 29.0.h,
        width: 1.0.sw,
        child: IndicatorSliderWidget(key: key, length: widget.images.length),
      ),
    );

    Widget widgetSlider = SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: widgets,
      ),
    );
    if (widget.card) {
      widgetSlider = MyCardWidget(
        padding: EdgeInsets.zero,
        margin: widget.margin,
        cardColor: Colors.white,
        elevation: 0.0,
        child: widgetSlider,
      );
    }
    return widgetSlider;
  }
}

class IndicatorSliderWidget extends StatefulWidget {
  const IndicatorSliderWidget({
    Key? key,
    required this.length,
  }) : super(key: key);

  final int length;

  @override
  State<IndicatorSliderWidget> createState() => IndicatorSliderWidgetState();
}

class IndicatorSliderWidgetState extends State<IndicatorSliderWidget> {
  late int selected;

  void changePage(int i) {
    setState(() => selected = i);
  }

  @override
  void initState() {
    selected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.0.spMin,
      child: ListView.separated(
        itemCount: widget.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return AnimatedContainer(
            width: selected == i ? 20.0.w : 7.spMin,
            height: 7.spMin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200.0),
              color: AppColorManager.mainColor.withOpacity(selected == i ? 1 : 0.3),
            ),
            duration: const Duration(milliseconds: 150),
          );
        },
        separatorBuilder: (context, i) => 5.0.horizontalSpace,
      ),
    );
  }
}

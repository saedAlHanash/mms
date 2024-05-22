// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mms/core/strings/app_color_manager.dart';
// import 'package:mms/generated/assets.dart';
//
// import 'package:image_multi_type/image_multi_type.dart';
//
// class IconStepperDemo extends StatelessWidget {
//   const IconStepperDemo({super.key, required this.items});
//
//   final List<StepperItem> items;
//
//   @override
//   Widget build(BuildContext context) {
//     var activeStep = 0;
//
//     for (var i = 0; i < items.length; i++) {
//       if (items[i].active) {
//         activeStep = i;
//         break;
//       }
//     }
//     return ImageStepper(
//       images: items.map(
//             (e) {
//           final size = e.active ? 24.0.spMin : 14.0.spMin;
//           return  ImageMultiType(url:
//             e.complete
//                 ? Assets.iconsDone
//                 : e.active
//                 ? Assets.iconsActiveStep
//                 : Assets.iconsDisactiveStep,
//             height: size,
//             width: size,
//           );
//         },
//       ).toList(),
//       activeStep: activeStep,
//       enableStepTapping: false,
//       steppingEnabled: false,
//       enableNextPreviousButtons: false,
//       lineColor: AppColorManager.mainColor,
//       activeStepColor: Colors.transparent,
//     );
//   }
// }
//
// class StepperItem {
//   StepperItem({
//     required this.active,
//     required this.complete,
//   });
//
//   bool active;
//   bool complete;
//
//   Map<String, dynamic> toMap() {
//     return {
//       'active': active,
//       'complete': complete,
//     };
//   }
//
//   factory StepperItem.fromMap(Map<String, dynamic> map) {
//     return StepperItem(
//       active: map['active'] as bool,
//       complete: map['complete'] as bool,
//     );
//   }
//
// //</editor-fold>
// }
//
// /// Callback is fired when a step is reached.
// typedef OnStepReached = void Function(int index);
//
// class ImageStepper extends StatelessWidget {
//   /// Each image defines a step. Hence, total number of images determines the total number of steps.
//   final List<Widget> images;
//
//   /// Whether to enable or disable the next and previous buttons.
//   final bool enableNextPreviousButtons;
//
//   /// Whether to allow tapping a step to move to that step or not.
//   final bool enableStepTapping;
//
//   /// Icon to be used for the previous button.
//   final Icon? previousButtonIcon;
//
//   /// Icon to be used for the next button.
//   final Icon? nextButtonIcon;
//
//   /// Determines what should happen when a step is reached. This callback provides the __index__ of the step that was reached.
//   final OnStepReached? onStepReached;
//
//   /// Whether to show the steps horizontally or vertically. __Note: Ensure horizontal stepper goes inside a column and vertical goes inside a row.__
//   final Axis direction;
//
//   /// The color of the step when it is not reached.
//   final Color? stepColor;
//
//   /// The amount of padding inside a step.
//   final double stepPadding;
//
//   /// The color of a step when it is reached.
//   final Color? activeStepColor;
//
//   /// The border color of a step when it is reached.
//   final Color? activeStepBorderColor;
//
//   /// The border width of the active step.
//   final double activeStepBorderWidth;
//
//   /// Determines how far away the border should be drawn from the step when it is reached.
//   final double activeStepBorderPadding;
//
//   /// The color of the line that separates the steps.
//   final Color? lineColor;
//
//   /// The length of the line that separates the steps.
//   final double lineLength;
//
//   /// The radius of individual dot within the line that separates the steps.
//   final double lineDotRadius;
//
//   /// The radius of a step.
//   final double stepRadius;
//
//   /// The animation effect to show when a step is reached.
//   final Curve stepReachedAnimationEffect;
//
//   /// The duration of the animation effect to show when a step is reached.
//   final Duration stepReachedAnimationDuration;
//
//   /// Whether the stepping is enabled or disabled.
//   final bool steppingEnabled;
//
//   /// Whether the scrolling is disabled or not.
//   final bool scrollingDisabled;
//
//   /// The currently active step.
//   final int activeStep;
//
//   /// Specifies the alignment of the ImageStepper
//   final AlignmentGeometry alignment;
//
//   /// Creates an ImageStepper widget.
//   const ImageStepper({
//     super.key,
//     this.images = const [],
//     this.enableNextPreviousButtons = true,
//     this.enableStepTapping = true,
//     this.previousButtonIcon,
//     this.nextButtonIcon,
//     this.onStepReached,
//     this.direction = Axis.horizontal,
//     this.stepColor,
//     this.stepPadding = 0.0,
//     this.activeStepColor,
//     this.activeStepBorderColor,
//     this.activeStepBorderWidth = 0.5,
//     this.activeStepBorderPadding = 1.0,
//     this.lineColor,
//     this.lineLength = 50.0,
//     this.lineDotRadius = 1.0,
//     this.stepRadius = 24.0,
//     this.stepReachedAnimationEffect = Curves.bounceOut,
//     this.stepReachedAnimationDuration = const Duration(seconds: 1),
//     this.steppingEnabled = true,
//     this.scrollingDisabled = false,
//     this.activeStep = 0,
//     this.alignment = Alignment.center,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseStepper(
//       nextPreviousButtonsDisabled: enableNextPreviousButtons,
//       stepTappingDisabled: enableStepTapping,
//       previousButtonIcon: previousButtonIcon,
//       nextButtonIcon: nextButtonIcon,
//       onStepReached: onStepReached,
//       direction: direction,
//       stepColor: stepColor,
//       activeStepColor: activeStepColor,
//       activeStepBorderColor: activeStepBorderColor,
//       activeStepBorderWidth: activeStepBorderWidth,
//       lineColor: lineColor,
//       lineLength: lineLength,
//       lineDotRadius: lineDotRadius,
//       stepRadius: stepRadius,
//       stepReachedAnimationEffect: stepReachedAnimationEffect,
//       stepReachedAnimationDuration: stepReachedAnimationDuration,
//       steppingEnabled: steppingEnabled,
//       margin: activeStepBorderPadding,
//       padding: stepPadding,
//       scrollingDisabled: scrollingDisabled,
//       activeStep: activeStep,
//       alignment: alignment,
//       children: images,
//     );
//   }
// }
//
// class BaseStepper extends StatefulWidget {
//   /// Creates a basic stepper.
//   BaseStepper({
//      super.key,
//     this.children,
//     this.nextPreviousButtonsDisabled = true,
//     this.stepTappingDisabled = true,
//     this.previousButtonIcon,
//     this.nextButtonIcon,
//     this.onStepReached,
//     this.direction = Axis.horizontal,
//     this.stepColor,
//     this.activeStepColor,
//     this.activeStepBorderColor,
//     this.lineColor,
//     this.lineLength = 50.0,
//     this.lineDotRadius = 1.0,
//     this.stepRadius = 24.0,
//     this.stepReachedAnimationEffect = Curves.bounceOut,
//     this.stepReachedAnimationDuration = const Duration(seconds: 1),
//     this.steppingEnabled = true,
//     this.padding = 5.0,
//     this.margin = 1.0,
//     this.activeStepBorderWidth = 0.5,
//     this.scrollingDisabled = false,
//     this.activeStep = 0,
//     this.alignment,
//   }) {
//     assert(
//     lineDotRadius <= 10 && lineDotRadius > 0,
//     'lineDotRadius must be less than or equal to 10 and greater than 0',
//     );
//
//     assert(
//     stepRadius > 0,
//     'iconIndicatorRadius must be greater than 0',
//     );
//
//     assert(
//     activeStep >= 0 && activeStep <= children!.length,
//     'Error: Active Step out of range',
//     );
//   }
//
//   /// Each child defines a step. Hence, total number of children determines the total number of steps.
//   final List<Widget>? children;
//
//   /// Whether to enable or disable the next and previous buttons.
//   final bool nextPreviousButtonsDisabled;
//
//   /// Whether to allow tapping a step to move to that step or not.
//   final bool stepTappingDisabled;
//
//   /// Icon to be used for the previous button.
//   final Icon? previousButtonIcon;
//
//   /// Icon to be used for the next button.
//   final Icon? nextButtonIcon;
//
//   /// This callback provides the __index__ of the step that is reached.
//   final OnStepReached? onStepReached;
//
//   /// Whether to show the steps horizontally or vertically. __Note: Ensure horizontal stepper goes inside a column and vertical goes inside a row.__
//   final Axis direction;
//
//   /// The color of the step when it is not reached.
//   final Color? stepColor;
//
//   /// The color of a step when it is reached.
//   final Color? activeStepColor;
//
//   /// The border color of a step when it is reached.
//   final Color? activeStepBorderColor;
//
//   /// The color of the line that separates the steps.
//   final Color? lineColor;
//
//   /// The length of the line that separates the steps.
//   final double lineLength;
//
//   /// The radius of individual dot within the line that separates the steps.
//   final double lineDotRadius;
//
//   /// The radius of a step.
//   final double stepRadius;
//
//   /// The animation effect to show when a step is reached.
//   final Curve stepReachedAnimationEffect;
//
//   /// The duration of the animation effect to show when a step is reached.
//   final Duration stepReachedAnimationDuration;
//
//   /// Whether the stepping is enabled or disabled.
//   final bool steppingEnabled;
//
//   /// Amount of padding on each side of the child widget.
//   final double padding;
//
//   /// Amount of margin on each side of the step.
//   final double margin;
//
//   /// The width of the active step border.
//   final double activeStepBorderWidth;
//
//   /// Whether to disable scrolling or not.
//   final bool scrollingDisabled;
//
//   /// The step that is currently active.
//   final int activeStep;
//
//   /// Specifies the alignment of the stepper.
//   final AlignmentGeometry? alignment;
//
//   @override
//   BaseStepperState createState() => BaseStepperState();
// }
//
// class BaseStepperState extends State<BaseStepper> {
//   ScrollController? _scrollController;
//   late int _selectedIndex;
//
//   @override
//   void initState() {
//     _selectedIndex = widget.activeStep;
//     _scrollController = ScrollController();
//     super.initState();
//   }
//
//   @override
//   void didUpdateWidget(BaseStepper oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     // Verify that the active step falls within a valid range.
//     if (widget.activeStep >= 0 && widget.activeStep < widget.children!.length) {
//       _selectedIndex = widget.activeStep;
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController!.dispose();
//     super.dispose();
//   }
//
//   /// Controls the step scrolling.
//   void _afterLayout(_) {
//     // ! Provide detailed explanation.
//     for (int i = 0; i < widget.children!.length; i++) {
//       _scrollController!.animateTo(
//         i * ((widget.stepRadius * 2) + widget.lineLength),
//         duration: widget.stepReachedAnimationDuration,
//         curve: widget.stepReachedAnimationEffect,
//       );
//
//       if (_selectedIndex == i) break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Controls scrolling behavior.
//     if (!widget.scrollingDisabled) {
//       WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
//     }
//
//     return widget.direction == Axis.horizontal
//         ? Row(
//       children: <Widget>[
//         widget.nextPreviousButtonsDisabled
//             ? _previousButton()
//             : Container(),
//         Expanded(
//           child: _stepperBuilder(),
//         ),
//         widget.nextPreviousButtonsDisabled ? _nextButton() : Container(),
//       ],
//     )
//         : Column(
//       children: <Widget>[
//         widget.nextPreviousButtonsDisabled
//             ? _previousButton()
//             : Container(),
//         Expanded(
//           child: _stepperBuilder(),
//         ),
//         widget.nextPreviousButtonsDisabled ? _nextButton() : Container(),
//       ],
//     );
//   }
//
//   /// Builds the stepper.
//   Widget _stepperBuilder() {
//     return Align(
//       alignment: widget.alignment ?? Alignment.center,
//       child: SingleChildScrollView(
//         scrollDirection: widget.direction,
//         controller: _scrollController,
//         physics: widget.scrollingDisabled
//             ? const NeverScrollableScrollPhysics()
//             : const ClampingScrollPhysics(),
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 8.0),
//           padding: const EdgeInsets.all(8.0),
//           child: widget.direction == Axis.horizontal
//               ? Row(children: _buildSteps())
//               : Column(children: _buildSteps()),
//         ),
//       ),
//     );
//   }
//
//   /// Builds the stepper steps.
//   List<Widget> _buildSteps() {
//     return List.generate(
//       widget.children!.length,
//           (index) {
//         return widget.direction == Axis.horizontal
//             ? Row(
//           children: <Widget>[
//             _customizedIndicator(index),
//             _customizedDottedLine(index, Axis.horizontal),
//           ],
//         )
//             : Column(
//           children: <Widget>[
//             _customizedIndicator(index),
//             _customizedDottedLine(index, Axis.vertical),
//           ],
//         );
//       },
//     );
//   }
//
//   /// A customized IconStep.
//   Widget _customizedIndicator(int index) {
//     return BaseIndicator(
//       isSelected: _selectedIndex == index,
//       onPressed: widget.stepTappingDisabled
//           ? () {
//         if (widget.steppingEnabled) {
//           setState(() {
//             _selectedIndex = index;
//
//             if (widget.onStepReached != null) {
//               widget.onStepReached!(_selectedIndex);
//             }
//           });
//         }
//       }
//           : null,
//       color: widget.stepColor,
//       activeColor: widget.activeStepColor,
//       activeBorderColor: widget.activeStepBorderColor,
//       radius: widget.stepRadius,
//       padding: widget.padding,
//       margin: widget.margin,
//       activeBorderWidth: widget.activeStepBorderWidth,
//       child: widget.children![index],
//     );
//   }
//
//   /// A customized DottedLine.
//   Widget _customizedDottedLine(int index, Axis axis) {
//     return index < widget.children!.length - 1
//         ? DottedLine(
//       length: widget.lineLength,
//       color: widget.lineColor ?? Colors.blue,
//       dotRadius: widget.lineDotRadius,
//       spacing: 5.0,
//       axis: axis,
//     )
//         : Container();
//   }
//
//   /// The previous button.
//   Widget _previousButton() {
//     return IgnorePointer(
//       ignoring: _selectedIndex == 0,
//       child: IconButton(
//         visualDensity: VisualDensity.compact,
//         icon: widget.previousButtonIcon ??
//             Icon(
//               widget.direction == Axis.horizontal
//                   ? Icons.arrow_left
//                   : Icons.arrow_drop_up,
//             ),
//         onPressed: _goToPreviousStep,
//       ),
//     );
//   }
//
//   /// The next button.
//   Widget _nextButton() {
//     return IgnorePointer(
//       ignoring: _selectedIndex == widget.children!.length - 1,
//       child: IconButton(
//         visualDensity: VisualDensity.compact,
//         icon: widget.nextButtonIcon ??
//             Icon(
//               widget.direction == Axis.horizontal
//                   ? Icons.arrow_right
//                   : Icons.arrow_drop_down,
//             ),
//         onPressed: _goToNextStep,
//       ),
//     );
//   }
//
//   /// Contains the logic for going to the next step.
//   void _goToNextStep() {
//     if (_selectedIndex < widget.children!.length - 1 &&
//         widget.steppingEnabled) {
//       setState(() {
//         _selectedIndex++;
//
//         if (widget.onStepReached != null) {
//           widget.onStepReached!(_selectedIndex);
//         }
//       });
//     }
//   }
//
//   /// Controls the logic for going to the previous step.
//   void _goToPreviousStep() {
//     if (_selectedIndex > 0) {
//       setState(() {
//         _selectedIndex--;
//
//         if (widget.onStepReached != null) {
//           widget.onStepReached!(_selectedIndex);
//         }
//       });
//     }
//   }
// }
//
// class BaseIndicator extends StatelessWidget {
//   /// Whether this indicator is selected or not.
//   final bool isSelected;
//
//   /// The child to be placed within the indicator.
//   final Widget? child;
//
//   /// Action to be taken when this indictor is pressed.
//   final Function? onPressed;
//
//   /// Color of this indicator when it is not selected.
//   final Color? color;
//
//   /// Color of this indicator when it is selected.
//   final Color? activeColor;
//
//   /// Border color of this indicator when it is selected.
//   final Color? activeBorderColor;
//
//   /// The border width of this indicator when it is selected.
//   final double activeBorderWidth;
//
//   /// Radius of this indicator.
//   final double radius;
//
//   /// The amount of padding around each side of the child.
//   final double padding;
//
//   /// The amount of margin around each side of the indicator.
//   final double margin;
//
//   const BaseIndicator({super.key,
//     this.isSelected = false,
//     this.child,
//     this.onPressed,
//     this.color,
//     this.activeColor,
//     this.activeBorderColor,
//     this.radius = 24.0,
//     this.padding = 5.0,
//     this.margin = 1.0,
//     this.activeBorderWidth = 0.5,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: isSelected ? EdgeInsets.all(margin) : EdgeInsets.zero,
//       decoration: const BoxDecoration(shape: BoxShape.circle),
//       child: InkWell(onTap: onPressed as void Function()?, child: child),
//     );
//   }
// }
//
// class DottedLine extends StatelessWidget {
//   /// Width of the dotted line.
//   final double length;
//
//   /// Color of the dotted line.
//   final Color color;
//
//   /// Radius of each dot in the dotted line.
//   final double dotRadius;
//
//   /// Spacing between the dots in the dotted line.
//   final double spacing;
//
//   final Axis axis;
//
//   const DottedLine({
//     super.key,
//     this.length = 50.0,
//     this.color = Colors.grey,
//     this.dotRadius = 2.0,
//     this.spacing = 3.0,
//     this.axis = Axis.horizontal,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // If this is not applied, top half of the dot gets offscreen, hence, hidden.
//       margin: EdgeInsets.only(top: dotRadius),
//       width: axis == Axis.horizontal ? length : 0.0,
//       height: axis == Axis.vertical ? length : 0.0,
//       child: CustomPaint(
//         painter: _DottedLinePainter(
//           brush: Paint()..color = color,
//           length: length,
//           dotRadius: dotRadius,
//           spacing: spacing,
//           axis: axis,
//         ),
//       ),
//     );
//   }
// }
//
// class _DottedLinePainter extends CustomPainter {
//   final double length;
//   final double dotRadius;
//   final double spacing;
//   final Paint? brush;
//   final Axis axis;
//
//   _DottedLinePainter({
//     this.length = 100,
//     this.brush,
//     this.dotRadius = 2.0,
//     this.spacing = 3.0,
//     this.axis = Axis.horizontal,
//   }) {
//     assert(brush != null);
//     assert(dotRadius > 0, 'dotRadius must be greater than 0');
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     double start = 0.0;
//
//     // Length of the line is calculated by dividing the supplied length [to] by dotRadius * space.
//     int calculatedLength = length ~/ (dotRadius * spacing);
//
//     for (int i = 1; i < calculatedLength; i++) {
//       // New start becomes:
//       start += dotRadius * spacing;
//
//       canvas.drawCircle(
//         Offset(
//           axis == Axis.horizontal ? start : 0.0,
//           axis == Axis.horizontal ? 0.0 : start,
//         ),
//         dotRadius,
//         brush!,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

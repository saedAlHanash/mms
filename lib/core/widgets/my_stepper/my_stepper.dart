// // Copyright 2014 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//  
// import 'package:mms/core/strings/app_color_manager.dart';
// import 'package:mms/generated/assets.dart';
//
// // TODO(dragostis): Missing functionality:
// //   * mobile horizontal mode with adding/removing steps
// //   * alternative labeling
// //   * stepper feedback in the case of high-latency interactions
//
// /// The state of a [MyStep] which is used to control the style of the circle and
// /// text.
// ///
// /// See also:
// ///
// ///  * [MyStep]
// enum StepState {
//   /// A step that displays its index in its circle.
//   indexed,
//
//   /// A step that displays a tick icon in its circle.
//   complete,
//
//   /// A step that is disabled and does not to react to taps.
//   disabled,
//
//   /// A step that is currently having an error. e.g. the user has submitted wrong
//   /// input.
//   error,
// }
//
// /// Defines the [MyStepper]'s main axis.
// enum StepperType {
//   /// A vertical layout of the steps with their content in-between the titles.
//   vertical,
//
//   /// A horizontal layout of the steps with their content below the titles.
//   horizontal,
// }
//
// /// Container for all the information necessary to build a Stepper widget's
// /// forward and backward controls for any given step.
// ///
// /// Used by [MyStepper.controlsBuilder].
// @immutable
// class ControlsDetails {
//   /// Creates a set of details describing the Stepper.
//   const ControlsDetails({
//     required this.currentStep,
//     required this.stepIndex,
//     this.onStepCancel,
//     this.onStepContinue,
//   });
//
//   /// Index that is active for the surrounding [MyStepper] widget. This may be
//   /// different from [stepIndex] if the user has just changed steps and we are
//   /// currently animating toward that step.
//   final int currentStep;
//
//   /// Index of the step for which these controls are being built. This is
//   /// not necessarily the active index, if the user has just changed steps and
//   /// this step is animating away. To determine whether a given builder is building
//   /// the active step or the step being navigated away from, see [isActive].
//   final int stepIndex;
//
//   /// The callback called when the 'continue' button is tapped.
//   ///
//   /// If null, the 'continue' button will be disabled.
//   final VoidCallback? onStepContinue;
//
//   /// The callback called when the 'cancel' button is tapped.
//   ///
//   /// If null, the 'cancel' button will be disabled.
//   final VoidCallback? onStepCancel;
//
//   /// True if the indicated step is also the current active step. If the user has
//   /// just activated the transition to a new step, some [MyStepper.type] values will
//   /// lead to both steps being rendered for the duration of the animation shifting
//   /// between steps.
//   bool get isActive => currentStep == stepIndex;
// }
//
// /// A builder that creates a widget given the two callbacks `onStepContinue` and
// /// `onStepCancel`.
// ///
// /// Used by [MyStepper.controlsBuilder].
// ///
// /// See also:
// ///
// ///  * [WidgetBuilder], which is similar but only takes a [BuildContext].
// typedef ControlsWidgetBuilder = Widget Function(
//     BuildContext context, ControlsDetails details);
//
// @immutable
// class MyStep {
//   /// Creates a step for a [MyStepper].
//   ///
//   /// The [title], [content], and [state] arguments must not be null.
//   const MyStep({
//     required this.title,
//     this.subtitle,
//     required this.content,
//     this.state = StepState.indexed,
//     this.isActive = false,
//     this.label,
//   })  : assert(title != null),
//         assert(content != null),
//         assert(state != null);
//
//   /// The title of the step that typically describes it.
//   final Widget title;
//
//   /// The subtitle of the step that appears below the title and has a smaller
//   /// font size. It typically gives more details that complement the title.
//   ///
//   /// If null, the subtitle is not shown.
//   final Widget? subtitle;
//
//   /// The content of the step that appears below the [title] and [subtitle].
//   ///
//   /// Below the content, every step has a 'continue' and 'cancel' button.
//   final Widget content;
//
//   /// The state of the step which determines the styling of its components
//   /// and whether steps are interactive.
//   final StepState state;
//
//   /// Whether or not the step is active. The flag only influences styling.
//   final bool isActive;
//
//   /// Only [StepperType.horizontal], Optional widget that appears under the [title].
//   /// By default, uses the `bodyLarge` theme.
//   final Widget? label;
// }
//
// class MyStepper extends StatefulWidget {
//   /// Creates a stepper from a list of steps.
//   ///
//   /// This widget is not meant to be rebuilt with a different list of steps
//   /// unless a key is provided in order to distinguish the old stepper from the
//   /// new one.
//   ///
//   /// The [steps], [type], and [currentStep] arguments must not be null.
//   const MyStepper({
//     super.key,
//     required this.steps,
//     this.physics,
//     this.type = StepperType.vertical,
//     this.currentStep = 0,
//     this.onStepTapped,
//     this.onStepContinue,
//     this.onStepCancel,
//     this.controlsBuilder,
//     this.elevation,
//     this.margin,
//   })  : assert(steps != null),
//         assert(type != null),
//         assert(currentStep != null),
//         assert(0 <= currentStep && currentStep < steps.length);
//
//   /// The steps of the stepper whose titles, subtitles, icons always get shown.
//   ///
//   /// The length of [steps] must not change.
//   final List<MyStep> steps;
//
//   /// How the stepper's scroll view should respond to user input.
//   ///
//   /// For example, determines how the scroll view continues to
//   /// animate after the user stops dragging the scroll view.
//   ///
//   /// If the stepper is contained within another scrollable it
//   /// can be helpful to set this property to [ClampingScrollPhysics].
//   final ScrollPhysics? physics;
//
//   /// The type of stepper that determines the layout. In the case of
//   /// [StepperType.horizontal], the content of the current step is displayed
//   /// underneath as opposed to the [StepperType.vertical] case where it is
//   /// displayed in-between.
//   final StepperType type;
//
//   /// The index into [steps] of the current step whose content is displayed.
//   final int currentStep;
//
//   /// The callback called when a step is tapped, with its index passed as
//   /// an argument.
//   final ValueChanged<int>? onStepTapped;
//
//   /// The callback called when the 'continue' button is tapped.
//   ///
//   /// If null, the 'continue' button will be disabled.
//   final VoidCallback? onStepContinue;
//
//   /// The callback called when the 'cancel' button is tapped.
//   ///
//   /// If null, the 'cancel' button will be disabled.
//   final VoidCallback? onStepCancel;
//
//   /// The callback for creating custom controls.
//   ///
//   /// If null, the default controls from the current theme will be used.
//   ///
//   /// This callback which takes in a context and a [ControlsDetails] object, which
//   /// contains step information and two functions: [onStepContinue] and [onStepCancel].
//   /// These can be used to control the stepper. For example, reading the
//   /// [ControlsDetails.currentStep] value within the callback can change the text
//   /// of the continue or cancel button depending on which step users are at.
//   ///
//   /// {@tool dartpad}
//   /// Creates a stepper control with custom buttons.
//   ///
//   /// ```dart
//   /// Widget build(BuildContext context) {
//   ///   return Stepper(
//   ///     controlsBuilder:
//   ///       (BuildContext context, ControlsDetails details) {
//   ///          return Row(
//   ///            children: <Widget>[
//   ///              TextButton(
//   ///                onPressed: details.onStepContinue,
//   ///                child: Text('Continue to Step ${details.stepIndex + 1}'),
//   ///              ),
//   ///              TextButton(
//   ///                onPressed: details.onStepCancel,
//   ///                child: Text('Back to Step ${details.stepIndex - 1}'),
//   ///              ),
//   ///            ],
//   ///          );
//   ///       },
//   ///     steps: const <Step>[
//   ///       Step(
//   ///         title: Text('A'),
//   ///         content: SizedBox(
//   ///           width: 100.0,
//   ///           height: 100.0,
//   ///         ),
//   ///       ),
//   ///       Step(
//   ///         title: Text('B'),
//   ///         content: SizedBox(
//   ///           width: 100.0,
//   ///           height: 100.0,
//   ///         ),
//   ///       ),
//   ///     ],
//   ///   );
//   /// }
//   /// ```
//   /// ** See code in examples/api/lib/material/stepper/stepper.controls_builder.0.dart **
//   /// {@end-tool}
//   final ControlsWidgetBuilder? controlsBuilder;
//
//   /// The elevation of this stepper's [Material] when [type] is [StepperType.horizontal].
//   final double? elevation;
//
//   /// custom margin on vertical stepper.
//   final EdgeInsetsGeometry? margin;
//
//   @override
//   State<MyStepper> createState() => _MyStepperState();
// }
//
// class _MyStepperState extends State<MyStepper> with TickerProviderStateMixin {
//   late List<GlobalKey> _keys;
//   final Map<int, StepState> _oldStates = <int, StepState>{};
//
//   @override
//   void initState() {
//     super.initState();
//     _keys = List<GlobalKey>.generate(
//       widget.steps.length,
//       (int i) => GlobalKey(),
//     );
//
//     for (int i = 0; i < widget.steps.length; i += 1) {
//       _oldStates[i] = widget.steps[i].state;
//     }
//   }
//
//   @override
//   void didUpdateWidget(MyStepper oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     assert(widget.steps.length == oldWidget.steps.length);
//
//     for (int i = 0; i < oldWidget.steps.length; i += 1) {
//       _oldStates[i] = oldWidget.steps[i].state;
//     }
//   }
//
//   bool _isFirst(int index) {
//     return index == 0;
//   }
//
//   bool _isLast(int index) {
//     return widget.steps.length - 1 == index;
//   }
//
//   bool _isCurrent(int index) {
//     return widget.currentStep == index;
//   }
//
//   Widget _buildLine(bool visible, int index) {
//     return visible
//         ? CustomPaint(
//             size: const Size(2, double.infinity),
//             painter: DashedLineVerticalPainter(
//                 AppColorManager.mainColor.withOpacity(0.3)),
//             child: SizedBox(
//               width: 1.0,
//               height: _isCurrent(index) ? 0.0 : 27.0.h,
//             ),
//           )
//         : const SizedBox();
//   }
//
//   Widget _buildIcon(int index) {
//     String iconName = Assets.iconsActiveStep;
//     switch (widget.steps[index].state) {
//       case StepState.indexed:
//         break;
//       case StepState.complete:
//         // TODO: Handle this case.
//         break;
//       case StepState.disabled:
//         // TODO: Handle this case.
//         break;
//       case StepState.error:
//         // TODO: Handle this case.
//         break;
//     }
//     return  ImageMultiType(url:
//       iconName,
//       width: 24.0.spMin,
//       height: 24.0.spMin,
//       color: _isCurrent(index)
//           ? AppColorManager.mainColor
//           : AppColorManager.mainColor.withOpacity(0.3),
//     );
//   }
//
//   Widget _buildVerticalHeader(int index) {
//     return Row(
//       children: [
//         Column(
//           children: <Widget>[
//             _buildLine(!_isFirst(index), index),
//             _buildIcon(index),
//             _buildLine(!_isLast(index), index),
//           ],
//         ),
//
//         Expanded(child: widget.steps[index].title),
//       ],
//     );
//   }
//
//   Widget _buildVerticalBody(int index) {
//     return Stack(
//       children: <Widget>[
//         Positioned(
//           top: 0.0,
//           left: 10.0,
//           bottom: 0.0,
//           child: Center(
//             child: CustomPaint(
//               size: const Size(2, double.infinity),
//               painter: DashedLineVerticalPainter(AppColorManager.mainColor),
//               child: const SizedBox(
//                 width: 1.0,
//                 height: double.infinity,
//               ),
//             ),
//           ),
//         ),
//         AnimatedCrossFade(
//           firstChild: const SizedBox.shrink(),
//           secondChild: Container(
//             margin: widget.margin ??
//                 const EdgeInsetsDirectional.only(
//                   start: 60.0,
//                   end: 24.0,
//                   bottom: 24.0,
//                 ),
//             child: widget.steps[index].content,
//           ),
//           firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
//           secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
//           sizeCurve: Curves.fastOutSlowIn,
//           crossFadeState: _isCurrent(index)
//               ? CrossFadeState.showSecond
//               : CrossFadeState.showFirst,
//           duration: kThemeAnimationDuration,
//         ),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       physics: widget.physics,
//       children: <Widget>[
//         for (int i = 0; i < widget.steps.length; i += 1)
//           Column(
//             key: _keys[i],
//             children: <Widget>[
//               InkWell(
//                 onTap: widget.steps[i].state != StepState.disabled
//                     ? () {
//                         Scrollable.ensureVisible(
//                           _keys[i].currentContext!,
//                           curve: Curves.fastOutSlowIn,
//                           duration: kThemeAnimationDuration,
//                         );
//
//                         widget.onStepTapped?.call(i);
//                       }
//                     : null,
//                 canRequestFocus: widget.steps[i].state != StepState.disabled,
//                 child: _buildVerticalHeader(i),
//               ),
//               _buildVerticalBody(i),
//             ],
//           ),
//       ],
//     );
//   }
// }
//
// class DashedLineVerticalPainter extends CustomPainter {
//   final Color color;
//
//   DashedLineVerticalPainter(this.color);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     double dashHeight = 10, dashSpace = 6, startY = 0;
//     final paint = Paint()
//       ..color = color
//       ..strokeWidth = size.width
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 2;
//     while (startY < size.height) {
//       canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
//       startY += dashHeight + dashSpace;
//     }
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

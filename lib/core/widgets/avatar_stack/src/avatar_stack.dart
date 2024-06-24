import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';

import 'widget_stack.dart';

import 'positions/positions.dart';
import 'positions/restricted_positions.dart';

/// Draws avatar stack which is presented by [ImageProvider].
///
/// An example of using avatars from Internet:
/// ```dart
/// AvatarStack(
///   height: 50,
///   avatars: [
///       NetworkImage('https://i.pravatar.cc/150?img=1'),
///       NetworkImage('https://i.pravatar.cc/150?img=2'),
///       NetworkImage('https://i.pravatar.cc/150?img=3'),
///   ],
/// ),
/// ```
///
/// If height or width are not set is gets them from parent.
class AvatarStack extends StatelessWidget {
  const AvatarStack({
    Key? key,
    required this.avatars,
    this.settings,
    this.infoWidgetBuilder,
    this.width,
    this.height,
    this.borderWidth,
    this.borderColor,
  }) : super(key: key);

  /// List of avatars.
  /// If you have avatars in Internet you can use [NetworkImage],
  /// for assets you can use [ExactAssetImage]
  /// for file you can use [FileImage]
  final List<dynamic> avatars;

  /// Algorithm for calculating positions
  final Positions? settings;

  /// Callback for drawing information of hidden widgets. Something like: (+7)
  final InfoWidgetBuilder? infoWidgetBuilder;

  /// Width of area the avatar stack is placed in.
  /// If [width] is not set it will be get from parent.
  final double? width;

  /// Height of the each elements of the avatar stack.
  /// If [height] is not set it will be get from parent.
  final double? height;

  /// Thickness of the avatar border
  final double? borderWidth;

  /// Color of the avatar border
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final _settings =
        settings ?? RestrictedPositions(maxCoverage: 0.4, minCoverage: 0.3);

    final border = BorderSide(
        color: borderColor ?? Theme.of(context).colorScheme.onPrimary,
        width: borderWidth ?? 2.0);

    return SizedBox(
      height: height,
      width: width,
      child: WidgetStack(
        positions: _settings,
        buildInfoWidget: infoWidgetBuilder,
        stackedWidgets:
            avatars.map((avatar) => CircleImageWidget(url: avatar)).toList(),
      ),
    );
  }
}

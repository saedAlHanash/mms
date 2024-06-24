import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'positions/positions.dart';

typedef InfoWidgetBuilder = Widget Function(int surplus);

/// Draws widgets stack. Can use any widgets.
class WidgetStack extends StatelessWidget {
  const WidgetStack({
    required this.positions,
    required this.stackedWidgets,
    required this.buildInfoWidget,
    super.key,
  });

  /// List of any widgets to draw
  final List<Widget> stackedWidgets;

  /// Algorithm of calculating positions
  final Positions positions;

  /// Callback for drawing information of hidden widgets. Something like: (+5)
  final InfoWidgetBuilder? buildInfoWidget;

  @override
  Widget build(BuildContext context) {
    positions.setAmountItems(stackedWidgets.length);
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      final isNotEnoughSpace =
          constraints.maxWidth <= 0 || constraints.maxHeight <= 0;
      if (isNotEnoughSpace) {
        return const SizedBox.shrink();
      }

      positions.setSize(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
      );

      return Stack(
        children: positions.calculate().map((position) {
          return Positioned(
            left: position.x,
            top: position.y,
            child: SizedBox(
              height: position.size,
              width: position.size,
              child: _buildStackedWidgetOrInfoWidget(position: position),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildStackedWidgetOrInfoWidget({
    required ItemPosition position,
  }) {
    if (position is InfoItemPosition) {
      return buildInfoWidget?.call(position.amountAdditionalItems)??0.0.verticalSpace;
    } else {
      return stackedWidgets[position.number];
    }
  }
}

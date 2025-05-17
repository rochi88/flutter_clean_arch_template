// Flutter imports:
import 'package:flutter/widgets.dart';

enum VisibilityFlag { visible, invisible, offscreen, gone }

class VisibleWidget extends StatelessWidget {
  final VisibilityFlag visibility;
  final Widget child;
  final Widget removedChild;

  VisibleWidget({super.key, required this.child, required this.visibility})
    : removedChild = Container();

  @override
  Widget build(BuildContext context) {
    if (visibility == VisibilityFlag.visible) {
      return child;
    } else if (visibility == VisibilityFlag.invisible) {
      return IgnorePointer(
        ignoring: true,
        child: Opacity(opacity: 0.0, child: child),
      );
    } else if (visibility == VisibilityFlag.offscreen) {
      return Offstage(offstage: true, child: child);
    } else {
      // If gone, we replace child with a custom widget (defaulting to a
      // [Container] with no defined size).
      return removedChild;
    }
  }
}

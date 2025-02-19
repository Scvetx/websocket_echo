/* Custom Widget - a container for screens with TextField inputs.
If user presses anywhere outside the TextField, the keyboard will be hidden.
*/

import 'package:flutter/material.dart';

class UnfocusContainerCmp extends StatelessWidget {
  const UnfocusContainerCmp({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: child,
  );
}

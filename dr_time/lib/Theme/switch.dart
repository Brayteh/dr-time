import 'package:flutter/material.dart';

class SwitchExample extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchExample({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: Colors.blue,
      onChanged: onChanged,
    );
  }
}

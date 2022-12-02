import 'package:flutter/material.dart';

class CheckboxField extends StatelessWidget {
  const CheckboxField({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
  });

  final String labelText;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => onChanged!(!value),
      child: Row(
        children: [
          AbsorbPointer(
            child: Checkbox(
              value: value,
              onChanged: onChanged,
            ),
          ),
          Text(
            labelText,
            style: textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

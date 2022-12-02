import 'package:flutter/material.dart';

class CheckboxField extends StatelessWidget {
  const CheckboxField({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final String labelText;
  final bool value;
  final void Function(bool?)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: enabled ? () => onChanged!(!value) : null,
      child: Row(
        children: [
          AbsorbPointer(
            child: Checkbox(
              value: value,
              activeColor:
                  enabled ? Theme.of(context).colorScheme.primary : Colors.grey,
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

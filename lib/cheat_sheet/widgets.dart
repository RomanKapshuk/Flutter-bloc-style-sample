import 'package:flutter/material.dart';
import 'package:test/cheat_sheet/login_screen/errors.dart';

class InputField extends StatefulWidget {
  final InputFieldData data;

  const InputField({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<InputField> createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  // Preffer to place disposable variables as final variables
  // in State of the Widget.
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          enabled: widget.data.enabled,
          controller: textController,
          decoration: InputDecoration.collapsed(
            hintText: widget.data.hint,
          ),
          onChanged: (value) {
            widget.data.value = value;
            // Remove error on editing without thole widget tree rebuild
            if (widget.data.error != null) {
              setState(() {
                widget.data.error = null;
              });
            }
          },
        ),
        if (widget.data.error != null)
          Text(
            widget.data.error?.suggestion ?? '',
            style: const TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

class InputFieldData {
  String value = '';
  bool? enabled;
  String? hint;
  ValidationError? error;
}

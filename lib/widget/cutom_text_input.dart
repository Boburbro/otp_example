import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CutomTextInput extends StatefulWidget {
  const CutomTextInput({
    super.key,
    this.focusNode,
    required this.onChanged,
    this.controller,
  });

  final FocusNode? focusNode;

  final ValueChanged<String> onChanged;
  final TextEditingController? controller;

  @override
  State<CutomTextInput> createState() => _CutomTextInputState();
}

class _CutomTextInputState extends State<CutomTextInput> {
  late MaskTextInputFormatter phoneMaskFormatter;
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();

    phoneMaskFormatter = MaskTextInputFormatter(
      mask: ' (##) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
    );
    super.initState();
  }

  @override
  void dispose() {
    phoneMaskFormatter.clear();
    if (widget.controller == null) controller.dispose();
    if (widget.focusNode == null) focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      cursorHeight: 16,
      onChanged: (String value) {
        if (value.length == 15) focusNode.unfocus();
        widget.onChanged(value);
      },
      keyboardType: TextInputType.phone,
      inputFormatters: [phoneMaskFormatter],
      decoration: InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 16),
            Icon(Icons.call, color: Colors.tealAccent),
            SizedBox(width: 12),
            Padding(
              padding: EdgeInsets.zero,
              child: Text(
                "+998 ",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        hintText: "(12) 345-67-89",
        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.black45,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.tealAccent, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.black45.withValues(alpha: .15),
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.black45.withValues(alpha: .15),
            width: 1.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

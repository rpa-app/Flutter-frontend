import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;

  CustomTextField(
      {Key? key,
      required this.label,
      this.initialValue,
      this.controller,
      this.hint = '',
      this.enabled = true,
      this.obscureText = false,
      this.onChanged,
      this.focusNode,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode _myFocusNode = FocusNode();

  @override
  void initState() {
    _myFocusNode = widget.focusNode ?? FocusNode();
    _myFocusNode.attach(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    Color unselectedBorderColor = HexColor('#1E1E1E');
    Color selectedBorderColor = themeData.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        onTap: _requestFocus,
        focusNode: _myFocusNode,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        cursorColor: themeData.colorScheme.primary,
        initialValue: widget.initialValue,
        cursorRadius: const Radius.circular(20),
        cursorWidth: 2.0,
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 200),
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hint,
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide:
                  BorderSide(width: 2, color: themeData.colorScheme.error)),
          focusColor: themeData.colorScheme.primary,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: selectedBorderColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 1, color: unselectedBorderColor)),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: themeData.colorScheme.primary),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: themeData.colorScheme.error),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: _myFocusNode.hasFocus
                  ? selectedBorderColor
                  : unselectedBorderColor),
        ),
        onFieldSubmitted: (value) {
          widget.controller?.text = value;
        },
      ),
    );
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_myFocusNode);
    });
  }
}

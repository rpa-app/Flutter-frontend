import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final Widget label;
  final String? hint;
  final Widget? prefixWidget;
  final bool isSearchField;
  final List<String>? searchResults;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final Function(String)? callback;
  final bool isLoading;
  const SearchField({
    super.key,
    required this.controller,
    required this.label,
    required this.onChanged,
    required this.isLoading,
    required this.isSearchField,
    this.callback,
    this.onSubmitted,
    this.searchResults,
    this.prefixWidget,
    this.hint,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          cursorColor: theme.colorScheme.primary,
          decoration: InputDecoration(
            label: widget.label,
            prefix: widget.prefixWidget,
            suffixIcon: widget.controller.text != ''
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.controller.text = '';
                      });
                    },
                    child: Icon(
                      Icons.highlight_remove_rounded,
                      color: theme.colorScheme.primary,
                    ))
                : const SizedBox(),
            filled: true,
            fillColor: theme.colorScheme.surface,
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: theme.colorScheme.primary),
            hintText: widget.hint ?? '',
            hintStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                fontSize: 14,
                color: theme.colorScheme.primary.withAlpha(100)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: theme.colorScheme.primary.withAlpha(60)),
                borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 1, color: theme.colorScheme.primary),
                borderRadius: BorderRadius.circular(15)),
          ),
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: theme.colorScheme.onSurface),
          onFieldSubmitted: (value) {
            widget.onSubmitted!(value);
            // widget.controller.text != '' || widget.isSearchField != false ? searchResults(theme) : {};
          },
          onChanged: (value) {
            widget.onChanged(value);
            // widget.controller.text != '' || widget.isSearchField != false ? searchResults(theme) : {};
          },
        ),
        // widget.searchResults != null ? const SizedBox(height: 16,) : const SizedBox(),
        // widget.controller.text != '' || widget.isSearchField != false ? searchResults(theme) : const SizedBox()
      ],
    );
  }
}

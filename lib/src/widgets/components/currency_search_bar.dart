import 'package:flutter/material.dart';

class CurrencySearchBar extends StatelessWidget {
  final bool visible;
  final bool autofocus;
  final TextEditingController? controller;
  final InputDecoration? inputDecoration;
  final String? searchHint;
  final Function(String query) onFilter;

  const CurrencySearchBar({
    super.key,
    this.visible = true,
    this.controller,
    this.inputDecoration,
    this.searchHint = "Search",
    required this.onFilter,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        autocorrect: false,
        decoration:
            inputDecoration ??
            InputDecoration(
              hintText: searchHint,
              prefixIcon: const Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
            ),
        onChanged: onFilter,
      ),
    );
  }
}

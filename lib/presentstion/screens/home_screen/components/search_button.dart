import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  bool isSearching;
  final VoidCallback? onPressed;
  SearchButton({required this.isSearching, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        !isSearching ? Icons.search : Icons.clear,
        color: Colors.black,
      ),
    );
  }
}

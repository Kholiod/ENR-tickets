import 'package:enr_tickets/core/utils/strings.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String) onChanged;

  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: Searchstation,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';
import 'sheet_header.dart';

class SortSheet extends StatelessWidget {
  const SortSheet({super.key, required this.selectedSort});

  final VehicleSort selectedSort;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          children: [
            const SheetHeader(title: 'SORT'),
            ...VehicleSort.values.map(
              (option) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  option.label,
                  style: TextStyle(
                    color: option == selectedSort
                        ? const Color(0xff1454a6)
                        : null,
                    fontWeight: option == selectedSort ? FontWeight.w700 : null,
                  ),
                ),
                onTap: () => Navigator.pop(context, option),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

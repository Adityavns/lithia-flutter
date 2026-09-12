import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';
import 'sheet_header.dart';

class FilterSelection {
  const FilterSelection({required this.conditions, required this.make});

  final List<VehicleCondition> conditions;
  final String? make;
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({
    super.key,
    required this.selectedConditions,
    required this.makes,
    required this.selectedMake,
  });

  final List<VehicleCondition> selectedConditions;
  final List<String> makes;
  final String? selectedMake;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late List<VehicleCondition> selectedConditions;
  String? selectedMake;

  @override
  void initState() {
    super.initState();
    selectedConditions = List.from(widget.selectedConditions);
    selectedMake = widget.selectedMake;
  }

  void _toggleCondition(VehicleCondition? condition) {
    setState(() {
      if (condition == null) {
        selectedConditions.clear();
      } else {
        if (selectedConditions.contains(condition)) {
          selectedConditions.remove(condition);
        } else {
          selectedConditions.add(condition);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SheetHeader(title: 'FILTER'),
          const SizedBox(height: 12),
          const Text(
            'Vehicle condition',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              FilterChipWidget(
                label: 'All',
                selected: selectedConditions.isEmpty,
                onSelected: (_) => _toggleCondition(null),
              ),
              FilterChipWidget(
                label: VehicleCondition.newVehicle.label,
                selected: selectedConditions.contains(
                  VehicleCondition.newVehicle,
                ),
                onSelected: (_) =>
                    _toggleCondition(VehicleCondition.newVehicle),
              ),
              FilterChipWidget(
                label: VehicleCondition.used.label,
                selected: selectedConditions.contains(VehicleCondition.used),
                onSelected: (_) => _toggleCondition(VehicleCondition.used),
              ),
              FilterChipWidget(
                label: VehicleCondition.cpo.label,
                selected: selectedConditions.contains(VehicleCondition.cpo),
                onSelected: (_) => _toggleCondition(VehicleCondition.cpo),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const FilterRowWidget(
            icon: Icons.verified_outlined,
            label: 'Certified Pre-Owned',
          ),
          const FilterRowWidget(
            icon: Icons.sell_outlined,
            label: 'Price Drop',
            detail: 'Explore vehicles with recently reduced prices',
          ),
          const FilterRowWidget(
            icon: Icons.speed_outlined,
            label: 'Low Mileage',
          ),
          MakeFilterRowWidget(
            icon: Icons.directions_car_outlined,
            label: 'Make, Model & Trim',
            makes: widget.makes,
            selectedMake: selectedMake,
            onChanged: (value) => setState(() => selectedMake = value),
          ),
          const FilterRowWidget(
            icon: Icons.palette_outlined,
            label: 'Body Style & Color',
            expandable: true,
          ),
          const FilterRowWidget(
            icon: Icons.calendar_month_outlined,
            label: 'Year & Mileage',
            expandable: true,
          ),
          const FilterRowWidget(
            icon: Icons.local_gas_station_outlined,
            label: 'Fuel Type & MPG',
            expandable: true,
          ),
          const FilterRowWidget(
            icon: Icons.settings_outlined,
            label: 'Drive Type & Engine',
            expandable: true,
          ),
          const FilterRowWidget(
            icon: Icons.featured_play_list_outlined,
            label: 'Features',
            expandable: true,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(
                context,
                FilterSelection(
                  conditions: selectedConditions,
                  make: selectedMake,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xff1957b8),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Show Results',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) => FilterChip(
    label: Text(label),
    selected: selected,
    onSelected: onSelected,
    selectedColor: const Color(0xffdce8fb),
  );
}

class FilterRowWidget extends StatelessWidget {
  const FilterRowWidget({
    super.key,
    required this.icon,
    required this.label,
    this.detail,
    this.expandable = false,
  });

  final IconData icon;
  final String label;
  final String? detail;
  final bool expandable;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: const Color(0xff1454a6), size: 29),
    title: Text(label),
    subtitle: detail == null ? null : Text(detail!),
    trailing: expandable
        ? const Icon(Icons.keyboard_arrow_down)
        : Switch(value: false, onChanged: (_) {}),
  );
}

class MakeFilterRowWidget extends StatelessWidget {
  const MakeFilterRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.makes,
    required this.selectedMake,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final List<String> makes;
  final String? selectedMake;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) => ExpansionTile(
    tilePadding: EdgeInsets.zero,
    leading: Icon(icon, color: const Color(0xff1454a6), size: 29),
    title: Text(label),
    children: [
      DropdownButtonFormField<String?>(
        initialValue: selectedMake,
        decoration: const InputDecoration(
          labelText: 'Make',
          border: OutlineInputBorder(),
        ),
        items: [
          const DropdownMenuItem<String?>(
            value: null,
            child: Text('All makes'),
          ),
          ...makes.map(
            (make) => DropdownMenuItem<String?>(value: make, child: Text(make)),
          ),
        ],
        onChanged: onChanged,
      ),
      const SizedBox(height: 12),
    ],
  );
}

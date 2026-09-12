import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/service_locator.dart';
import '../../core/utils/constants.dart';
import 'cubit/inventory_cubit.dart';
import 'cubit/inventory_state.dart';
import 'widgets/action_button.dart';
import 'widgets/error_view.dart';
import 'widgets/filter_sheet.dart';
import 'widgets/sort_sheet.dart';
import 'widgets/vehicle_card.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InventoryCubit>(
      create: (context) => getIt<InventoryCubit>()..loadInventory(),
      child: const InventoryView(),
    );
  }
}

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  String _conditionLabel(List<VehicleCondition> conditions) {
    if (conditions.length == 1) {
      return switch (conditions.first) {
        VehicleCondition.newVehicle => 'New ',
        VehicleCondition.used => 'Used ',
        VehicleCondition.cpo => 'CPO ',
      };
    }
    return '';
  }

  Future<void> _openFilterSheet(BuildContext context) async {
    final cubit = context.read<InventoryCubit>();
    final makes = cubit.state.makes;
    final selection = await showModalBottomSheet<FilterSelection>(
      context: context,
      isScrollControlled: true,
      builder: (context) => FilterSheet(
        selectedConditions: cubit.state.selectedConditions,
        makes: makes,
        selectedMake: cubit.state.selectedMake,
      ),
    );
    if (selection == null) return;
    cubit.updateFilter(conditions: selection.conditions, make: selection.make);
  }

  Future<void> _openSortSheet(BuildContext context) async {
    final cubit = context.read<InventoryCubit>();
    final sort = await showModalBottomSheet<VehicleSort>(
      context: context,
      builder: (context) => SortSheet(selectedSort: cubit.state.selectedSort),
    );
    if (sort == null) return;
    cubit.updateSort(sort);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          'driveway',
          style: TextStyle(
            color: Color(0xff252525),
            fontSize: 27,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.4,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<InventoryCubit>().refreshInventory(),
        child: BlocBuilder<InventoryCubit, InventoryState>(
          builder: (context, state) {
            return switch (state) {
              InventoryInitial() || InventoryLoading(vehicles: []) =>
                const Center(child: CircularProgressIndicator()),
              InventoryFailure(:final errorMessage, vehicles: []) => ErrorView(
                error: errorMessage,
                onRetry: () => context.read<InventoryCubit>().loadInventory(),
              ),
              _ => ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border.symmetric(
                        horizontal: BorderSide(color: Color(0xffe0e0e0)),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ActionButton(
                            icon: Icons.tune,
                            label: 'Filter',
                            onTap: () => _openFilterSheet(context),
                          ),
                        ),
                        const ActionDivider(),
                        Expanded(
                          child: ActionButton(
                            icon: Icons.swap_vert,
                            label: 'Sort',
                            onTap: () => _openSortSheet(context),
                          ),
                        ),
                        const ActionDivider(),
                        Expanded(
                          child: ActionButton(
                            icon: Icons.location_on_outlined,
                            label: state.userLocation.postalCode,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
                    child: Text(
                      '${state.totalItems} ${_conditionLabel(state.selectedConditions)}Cars For Sale',
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (state is InventoryLoading)
                    const LinearProgressIndicator(),
                  ...state.sortedVehicles.map(
                    (vehicle) => VehicleCard(vehicle: vehicle),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            };
          },
        ),
      ),
    );
  }
}

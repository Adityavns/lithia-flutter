import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constants.dart';
import '../../../domain/usecases/fetch_makes_use_case.dart';
import '../../../domain/usecases/search_vehicles_use_case.dart';
import 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit({
    required this._fetchMakesUseCase,
    required this._searchVehiclesUseCase,
  }) : super(const InventoryInitial());

  final FetchMakesUseCase _fetchMakesUseCase;
  final SearchVehiclesUseCase _searchVehiclesUseCase;

  List<VehicleCondition> get _effectiveConditions =>
      state.selectedConditions.isEmpty
      ? VehicleCondition.values
      : state.selectedConditions;

  Future<void> loadInventory({bool forceFetchMakes = false}) async {
    emit(
      InventoryLoading(
        vehicles: state.vehicles,
        makes: state.makes,
        totalItems: state.totalItems,
        selectedMake: state.selectedMake,
        selectedConditions: state.selectedConditions,
        selectedSort: state.selectedSort,
        userLocation: state.userLocation,
      ),
    );
    try {
      List<String> makes = state.makes;
      if (makes.isEmpty || forceFetchMakes) {
        final makesResponse = await _fetchMakesUseCase(
          vehicleConditions: _effectiveConditions,
          userLocation: state.userLocation,
        );
        makes = makesResponse.makes.toSet().toList();
      }

      final searchResult = await _searchVehiclesUseCase(
        make: state.selectedMake,
        vehicleConditions: _effectiveConditions,
        sort: state.selectedSort,
        userLocation: state.userLocation,
      );

      emit(
        InventorySuccess(
          makes: makes,
          vehicles: searchResult.vehicles,
          totalItems: searchResult.totalItems,
          selectedMake: state.selectedMake,
          selectedConditions: state.selectedConditions,
          selectedSort: state.selectedSort,
          userLocation: state.userLocation,
        ),
      );
    } catch (e) {
      emit(
        InventoryFailure(
          errorMessage: e.toString(),
          vehicles: state.vehicles,
          makes: state.makes,
          totalItems: state.totalItems,
          selectedMake: state.selectedMake,
          selectedConditions: state.selectedConditions,
          selectedSort: state.selectedSort,
          userLocation: state.userLocation,
        ),
      );
    }
  }

  Future<void> updateFilter({
    required List<VehicleCondition> conditions,
    required String? make,
  }) async {
    if (listEquals(conditions, state.selectedConditions) &&
        make == state.selectedMake) {
      return;
    }
    final conditionsChanged = !listEquals(conditions, state.selectedConditions);
    emit(
      InventoryLoading(
        vehicles: state.vehicles,
        makes: state.makes,
        totalItems: state.totalItems,
        selectedMake: make,
        selectedConditions: conditions,
        selectedSort: state.selectedSort,
        userLocation: state.userLocation,
      ),
    );
    await loadInventory(forceFetchMakes: conditionsChanged);
  }

  Future<void> updateSort(VehicleSort sort) async {
    if (sort == state.selectedSort) return;
    emit(
      InventoryLoading(
        vehicles: state.vehicles,
        makes: state.makes,
        totalItems: state.totalItems,
        selectedMake: state.selectedMake,
        selectedConditions: state.selectedConditions,
        selectedSort: sort,
        userLocation: state.userLocation,
      ),
    );
    await loadInventory();
  }

  Future<void> refreshInventory() async {
    await loadInventory(forceFetchMakes: true);
  }
}

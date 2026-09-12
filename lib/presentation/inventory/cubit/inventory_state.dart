import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/constants.dart';
import '../../../domain/entities/user_location.dart';
import '../../../domain/entities/vehicle.dart';

part 'inventory_state.freezed.dart';

@freezed
sealed class InventoryState with _$InventoryState {
  const InventoryState._();

  const factory InventoryState.initial({
    @Default([]) List<Vehicle> vehicles,
    @Default([]) List<String> makes,
    @Default(0) int totalItems,
    String? selectedMake,
    @Default([VehicleCondition.used, VehicleCondition.cpo])
    List<VehicleCondition> selectedConditions,
    @Default(VehicleSort.recommended) VehicleSort selectedSort,
    @Default(UserLocation(postalCode: '32095', state: 'FL'))
    UserLocation userLocation,
  }) = InventoryInitial;

  const factory InventoryState.loading({
    @Default([]) List<Vehicle> vehicles,
    @Default([]) List<String> makes,
    @Default(0) int totalItems,
    String? selectedMake,
    @Default([]) List<VehicleCondition> selectedConditions,
    @Default(VehicleSort.recommended) VehicleSort selectedSort,
    @Default(UserLocation(postalCode: '32095', state: 'FL'))
    UserLocation userLocation,
  }) = InventoryLoading;

  const factory InventoryState.success({
    required List<Vehicle> vehicles,
    required List<String> makes,
    required int totalItems,
    String? selectedMake,
    @Default([]) List<VehicleCondition> selectedConditions,
    @Default(VehicleSort.recommended) VehicleSort selectedSort,
    @Default(UserLocation(postalCode: '32095', state: 'FL'))
    UserLocation userLocation,
  }) = InventorySuccess;

  const factory InventoryState.failure({
    required String errorMessage,
    @Default([]) List<Vehicle> vehicles,
    @Default([]) List<String> makes,
    @Default(0) int totalItems,
    String? selectedMake,
    @Default([]) List<VehicleCondition> selectedConditions,
    @Default(VehicleSort.recommended) VehicleSort selectedSort,
    @Default(UserLocation(postalCode: '32095', state: 'FL'))
    UserLocation userLocation,
  }) = InventoryFailure;

  List<Vehicle> get sortedVehicles => vehicles;
}

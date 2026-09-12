import 'package:freezed_annotation/freezed_annotation.dart';

import 'vehicle.dart';

part 'vehicle_search_result.freezed.dart';

@freezed
abstract class VehicleSearchResult with _$VehicleSearchResult {
  const factory VehicleSearchResult({
    required List<Vehicle> vehicles,
    required int totalItems,
  }) = _VehicleSearchResult;
}

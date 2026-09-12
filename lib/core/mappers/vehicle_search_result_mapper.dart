import '../../domain/entities/vehicle_search_result.dart';
import '../models/vehicle_search_result_model.dart';
import 'vehicle_mapper.dart';

extension VehicleSearchResultModelMapper on VehicleSearchResultModel {
  VehicleSearchResult toEntity() => VehicleSearchResult(
    vehicles: vehicles.map((vehicle) => vehicle.toEntity()).toList(),
    totalItems: totalItems,
  );
}

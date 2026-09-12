import 'package:freezed_annotation/freezed_annotation.dart';

import 'vehicle_model.dart';

part 'vehicle_search_result_model.freezed.dart';

@freezed
abstract class VehicleSearchResultModel with _$VehicleSearchResultModel {
  const factory VehicleSearchResultModel({
    required List<VehicleModel> vehicles,
    required int totalItems,
  }) = _VehicleSearchResultModel;
}

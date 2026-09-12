import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_utils.dart';

part 'vehicle_model.freezed.dart';

@freezed
abstract class VehicleModel with _$VehicleModel {
  const factory VehicleModel({
    required String vehicleId,
    int? year,
    required String make,
    required String model,
    required String trim,
    String? price,
    int? mileage,
    required String condition,
    String? imageUrl,
    required bool isGoodDeal,
  }) = _VehicleModel;

  // GraphQL response nests year/make/model/trim under `ymmt` and the image under `image`.
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    final ymmt = asMap(json['ymmt']);
    final image = asMap(json['image']);
    return VehicleModel(
      vehicleId: asString(json['vehicleId']) ?? '',
      year: asInt(ymmt['year']),
      make: asString(ymmt['make']) ?? 'Unknown make',
      model: asString(ymmt['model']) ?? 'Unknown model',
      trim: asString(ymmt['trim']) ?? '',
      price: asString(json['price']),
      mileage: asInt(json['mileage']),
      condition: asString(json['condition']) ?? 'USED',
      imageUrl: asString(image['heroUrl']),
      isGoodDeal: json['isGoodDeal'] == true,
    );
  }
}

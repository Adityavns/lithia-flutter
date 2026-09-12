import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle.freezed.dart';

@freezed
abstract class Vehicle with _$Vehicle {
  const factory Vehicle({
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
  }) = _Vehicle;
}

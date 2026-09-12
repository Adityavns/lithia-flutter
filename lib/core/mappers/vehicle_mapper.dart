import '../../domain/entities/vehicle.dart';
import '../models/vehicle_model.dart';

extension VehicleModelMapper on VehicleModel {
  Vehicle toEntity() => Vehicle(
    vehicleId: vehicleId,
    year: year,
    make: make,
    model: model,
    trim: trim,
    price: price,
    mileage: mileage,
    condition: condition,
    imageUrl: imageUrl,
    isGoodDeal: isGoodDeal,
  );
}

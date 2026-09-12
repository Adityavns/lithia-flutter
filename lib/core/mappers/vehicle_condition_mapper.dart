import '../utils/constants.dart';

extension VehicleConditionMapper on VehicleCondition {
  String toApiValue() => switch (this) {
    VehicleCondition.used => 'USED',
    VehicleCondition.cpo => 'CPO',
    VehicleCondition.newVehicle => 'NEW',
  };
}

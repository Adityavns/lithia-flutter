import '../utils/constants.dart';

extension VehicleSortMapper on VehicleSort {
  String toApiValue() => switch (this) {
    VehicleSort.recommended => 'RELEVANCE',
    VehicleSort.lowestPrice => 'PRICE_LOWEST',
    VehicleSort.highestPrice => 'PRICE_HIGHEST',
    VehicleSort.lowestShippingCost => 'SHIPPING_FEE_LOWEST',
    VehicleSort.lowestMileage => 'MILEAGE_LOWEST',
    VehicleSort.newestInventory => 'INVENTORY_NEWEST',
    VehicleSort.newestYear => 'YEAR_NEWEST',
    VehicleSort.oldestYear => 'YEAR_OLDEST',
    VehicleSort.leasingLowest => 'LEASING_LOWEST',
  };
}

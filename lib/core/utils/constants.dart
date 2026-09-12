enum VehicleCondition {
  used('Used cars'),
  cpo('CPO'),
  newVehicle('New cars');

  const VehicleCondition(this.label);
  final String label;
}

enum VehicleSort {
  recommended('Recommended'),
  lowestPrice('Lowest Price'),
  highestPrice('Highest Price'),
  lowestShippingCost('Lowest Shipping Cost'),
  lowestMileage('Lowest Mileage'),
  newestInventory('Newest Inventory'),
  newestYear('Newest Year'),
  oldestYear('Oldest Year'),
  leasingLowest('Lowest Lease Payment');

  const VehicleSort(this.label);
  final String label;
}

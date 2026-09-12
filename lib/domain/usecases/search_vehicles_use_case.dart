import '../../core/repositories/driveway_repository.dart';
import '../../core/utils/constants.dart';
import '../entities/user_location.dart';
import '../entities/vehicle_search_result.dart';

abstract class SearchVehiclesUseCase {
  Future<VehicleSearchResult> call({
    String? make,
    required List<VehicleCondition> vehicleConditions,
    VehicleSort sort = VehicleSort.recommended,
    UserLocation? userLocation,
    int items = 24,
    int skip = 0,
  });
}

class SearchVehiclesUseCaseImpl implements SearchVehiclesUseCase {
  const SearchVehiclesUseCaseImpl(this._repository);

  final DrivewayRepository _repository;

  @override
  Future<VehicleSearchResult> call({
    String? make,
    required List<VehicleCondition> vehicleConditions,
    VehicleSort sort = VehicleSort.recommended,
    UserLocation? userLocation,
    int items = 24,
    int skip = 0,
  }) {
    return _repository.search(
      make: make,
      vehicleConditions: vehicleConditions,
      sort: sort,
      userLocation: userLocation,
      items: items,
      skip: skip,
    );
  }
}

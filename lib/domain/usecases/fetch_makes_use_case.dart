import '../../core/repositories/driveway_repository.dart';
import '../../core/utils/constants.dart';
import '../entities/fetch_makes_request.dart';
import '../entities/fetch_makes_response.dart';
import '../entities/user_location.dart';

abstract class FetchMakesUseCase {
  Future<FetchMakesResponse> call({
    List<VehicleCondition> vehicleConditions = VehicleCondition.values,
    UserLocation? userLocation,
  });
}

class FetchMakesUseCaseImpl implements FetchMakesUseCase {
  const FetchMakesUseCaseImpl(this._repository);

  final DrivewayRepository _repository;

  @override
  Future<FetchMakesResponse> call({
    List<VehicleCondition> vehicleConditions = VehicleCondition.values,
    UserLocation? userLocation,
  }) {
    return _repository.fetchMakes(
      FetchMakesRequest(
        vehicleConditions: vehicleConditions,
        userLocation: userLocation,
      ),
    );
  }
}

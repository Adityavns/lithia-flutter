import '../utils/constants.dart';
import '../../domain/entities/fetch_makes_request.dart';
import '../../domain/entities/fetch_makes_response.dart';
import '../../domain/entities/facet_bucket.dart';
import '../../domain/entities/user_location.dart';
import '../../domain/entities/vehicle_search_result.dart';

abstract class DrivewayRepository {
  Future<FetchMakesResponse> fetchMakes(FetchMakesRequest request);

  Future<List<FacetBucket>> fetchMakeCounts({
    String? make,
    UserLocation? userLocation,
  });

  Future<VehicleSearchResult> search({
    String? make,
    required List<VehicleCondition> vehicleConditions,
    VehicleSort sort = VehicleSort.recommended,
    UserLocation? userLocation,
    int items = 24,
    int skip = 0,
  });
}

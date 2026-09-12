import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/constants.dart';
import 'user_location.dart';

part 'fetch_makes_request.freezed.dart';

@freezed
abstract class FetchMakesRequest with _$FetchMakesRequest {
  const factory FetchMakesRequest({
    required List<VehicleCondition> vehicleConditions,
    UserLocation? userLocation,
  }) = _FetchMakesRequest;
}

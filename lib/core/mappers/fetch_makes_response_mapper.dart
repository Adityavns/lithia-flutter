import '../../domain/entities/fetch_makes_response.dart';
import '../models/fetch_makes_response_model.dart';

extension FetchMakesResponseModelMapper on FetchMakesResponseModel {
  FetchMakesResponse toEntity() => FetchMakesResponse(makes: makes);
}

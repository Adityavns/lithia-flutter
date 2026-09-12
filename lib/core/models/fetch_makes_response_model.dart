import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_makes_response_model.freezed.dart';

@freezed
abstract class FetchMakesResponseModel with _$FetchMakesResponseModel {
  const factory FetchMakesResponseModel({required List<String> makes}) =
      _FetchMakesResponseModel;
}

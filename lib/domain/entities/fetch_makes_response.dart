import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_makes_response.freezed.dart';

@freezed
abstract class FetchMakesResponse with _$FetchMakesResponse {
  const factory FetchMakesResponse({required List<String> makes}) =
      _FetchMakesResponse;
}

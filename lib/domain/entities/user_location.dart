import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_location.freezed.dart';

@freezed
abstract class UserLocation with _$UserLocation {
  const factory UserLocation({
    required String postalCode,
    required String state,
  }) = _UserLocation;
}

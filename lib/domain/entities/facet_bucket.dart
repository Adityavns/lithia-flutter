import 'package:freezed_annotation/freezed_annotation.dart';

part 'facet_bucket.freezed.dart';

@freezed
abstract class FacetBucket with _$FacetBucket {
  const factory FacetBucket({required String value, required int count}) =
      _FacetBucket;
}

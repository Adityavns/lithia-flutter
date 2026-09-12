import 'package:freezed_annotation/freezed_annotation.dart';

part 'facet_bucket_model.freezed.dart';

@freezed
abstract class FacetBucketModel with _$FacetBucketModel {
  const factory FacetBucketModel({required String value, required int count}) =
      _FacetBucketModel;
}

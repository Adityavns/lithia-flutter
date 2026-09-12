import '../../domain/entities/facet_bucket.dart';
import '../models/facet_bucket_model.dart';

extension FacetBucketModelMapper on FacetBucketModel {
  FacetBucket toEntity() => FacetBucket(value: value, count: count);
}

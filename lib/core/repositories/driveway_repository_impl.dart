import '../../domain/entities/fetch_makes_request.dart';
import '../../domain/entities/fetch_makes_response.dart';
import '../../domain/entities/facet_bucket.dart';
import '../../domain/entities/user_location.dart';
import '../../domain/entities/vehicle_search_result.dart';
import '../datasources/driveway_remote_data_source.dart';
import '../mappers/fetch_makes_response_mapper.dart';
import '../mappers/facet_bucket_mapper.dart';
import '../mappers/vehicle_search_result_mapper.dart';
import '../mappers/vehicle_sort_mapper.dart';
import '../mappers/vehicle_condition_mapper.dart';
import '../models/fetch_makes_response_model.dart';
import '../models/facet_bucket_model.dart';
import '../models/vehicle_model.dart';
import '../models/vehicle_search_result_model.dart';
import '../utils/constants.dart';
import '../utils/json_utils.dart';
import 'driveway_repository.dart';

class DrivewayRepositoryImpl implements DrivewayRepository {
  DrivewayRepositoryImpl(this._dataSource);

  final DrivewayRemoteDataSource _dataSource;

  @override
  Future<FetchMakesResponse> fetchMakes(FetchMakesRequest request) async {
    const query = r'''
      query Facet($facetFields: [FacetField!]!, $commonInputs: VehicleCommonInputsInput) {
        getFacets(facetFields: $facetFields, commonInputs: $commonInputs) {
          facets { field buckets { value } }
        }
      }
    ''';
    final commonInputs = <String, dynamic>{
      'filterInput': {
        'vehicleConditions': request.vehicleConditions
            .map((c) => c.toApiValue())
            .toList(),
      },
    };
    if (request.userLocation != null) {
      commonInputs['userLocation'] = {
        'postalCode': request.userLocation!.postalCode,
        'state': request.userLocation!.state,
      };
    }
    final data = await _dataSource.query(query, {
      'facetFields': ['MAKE'],
      'commonInputs': commonInputs,
    });
    final facets = asList(asMap(data['getFacets'])['facets']);
    final makeFacet = facets
        .map(asMap)
        .firstWhere(
          (facet) => facet['field'] == 'MAKE',
          orElse: () => <String, dynamic>{},
        );
    final makes = asList(makeFacet['buckets'])
        .map((bucket) => asString(asMap(bucket)['value']))
        .whereType<String>()
        .toSet()
        .toList();
    return FetchMakesResponseModel(makes: makes).toEntity();
  }

  @override
  Future<List<FacetBucket>> fetchMakeCounts({
    String? make,
    UserLocation? userLocation,
  }) async {
    const query = r'''
      query Facet($facetFields: [FacetField!]!, $commonInputs: VehicleCommonInputsInput) {
        getFacets(facetFields: $facetFields, commonInputs: $commonInputs) {
          facets { field buckets { value count } }
          totalCount
        }
      }
    ''';
    final filter = <String, dynamic>{
      'vehicleConditions': VehicleCondition.values
          .map((c) => c.toApiValue())
          .toList(),
    };
    if (make != null) {
      filter['makeModelTrims'] = [
        {'make': make, 'models': <String>[]},
      ];
    }
    final commonInputs = <String, dynamic>{'filterInput': filter};
    if (userLocation != null) {
      commonInputs['userLocation'] = {
        'postalCode': userLocation.postalCode,
        'state': userLocation.state,
      };
    }
    final data = await _dataSource.query(query, {
      'facetFields': ['MAKE'],
      'commonInputs': commonInputs,
    });
    final facets = asList(asMap(data['getFacets'])['facets']);
    final buckets = facets.isEmpty
        ? <dynamic>[]
        : asList(asMap(facets.first)['buckets']);
    return buckets
        .map(asMap)
        .map(
          (bucket) => FacetBucketModel(
            value: asString(bucket['value']) ?? 'Unknown',
            count: asInt(bucket['count']) ?? 0,
          ),
        )
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<VehicleSearchResult> search({
    String? make,
    required List<VehicleCondition> vehicleConditions,
    VehicleSort sort = VehicleSort.recommended,
    UserLocation? userLocation,
    int items = 24,
    int skip = 0,
  }) async {
    const query = r'''
      query Search($commonInputs: VehicleCommonInputsInput, $isDealershipDisclosuresEnabled: Boolean!) {
        search(commonInputs: $commonInputs) {
          pageInfo { totalItems items skip }
          vehicleResults {
            vehicleId
            ymmt { year make model trim }
            exteriorColor { name }
            price
            mileage
            condition
            isGoodDeal
            image { heroUrl spinUrl }
            disclaimer @include(if: $isDealershipDisclosuresEnabled)
          }
        }
      }
    ''';
    final filter = <String, dynamic>{
      'vehicleConditions': vehicleConditions
          .map((c) => c.toApiValue())
          .toList(),
    };
    if (make != null) {
      filter['makeModelTrims'] = [
        {'make': make, 'models': <String>[]},
      ];
    }
    final commonInputs = <String, dynamic>{
      'filterInput': filter,
      'paginationInput': {'items': items, 'skip': skip},
      'sortCriteria': sort.toApiValue(),
    };
    if (userLocation != null) {
      commonInputs['userLocation'] = {
        'postalCode': userLocation.postalCode,
        'state': userLocation.state,
      };
    }
    final data = await _dataSource.query(query, {
      'commonInputs': commonInputs,
      'isDealershipDisclosuresEnabled': false,
    });
    final search = asMap(data['search']);
    final pageInfo = asMap(search['pageInfo']);
    final model = VehicleSearchResultModel(
      totalItems: asInt(pageInfo['totalItems']) ?? 0,
      vehicles: asList(
        search['vehicleResults'],
      ).map(asMap).map(VehicleModel.fromJson).toList(),
    );
    return model.toEntity();
  }
}

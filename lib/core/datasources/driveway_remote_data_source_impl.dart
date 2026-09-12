import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/json_utils.dart';
import 'driveway_remote_data_source.dart';

const drivewayEndpoint = 'https://api-gateway.driveway.com/shop/gql/v5/graphql';

class DrivewayApiException implements Exception {
  const DrivewayApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class DrivewayRemoteDataSourceImpl implements DrivewayRemoteDataSource {
  DrivewayRemoteDataSourceImpl({
    required this.subscriptionKey,
    http.Client? client,
    this.endpoint = drivewayEndpoint,
  }) : _client = client ?? http.Client();

  final String subscriptionKey;
  final String endpoint;
  final http.Client _client;

  @override
  Future<Map<String, dynamic>> query(
    String query,
    Map<String, dynamic> variables,
  ) async {
    if (subscriptionKey.isEmpty) {
      throw const DrivewayApiException(
        'Missing DRIVEWAY_API_KEY. Launch with --dart-define=DRIVEWAY_API_KEY=your-key.',
      );
    }
    final response = await _client
        .post(
          Uri.parse(endpoint),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
            'ocp-apim-subscription-key': subscriptionKey,
          },
          body: jsonEncode({'query': query, 'variables': variables}),
        )
        .timeout(const Duration(seconds: 20));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw DrivewayApiException(
        'Driveway returned HTTP ${response.statusCode}.',
      );
    }
    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic>) {
      throw const DrivewayApiException(
        'Driveway returned an invalid response.',
      );
    }
    final errors = asList(body['errors']);
    if (errors.isNotEmpty) {
      final message =
          asString(asMap(errors.first)['message']) ?? 'GraphQL request failed.';
      throw DrivewayApiException(message);
    }
    return asMap(body['data']);
  }
}

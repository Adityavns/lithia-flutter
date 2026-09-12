Map<String, dynamic> asMap(Object? value) =>
    value is Map<String, dynamic> ? value : <String, dynamic>{};

List<dynamic> asList(Object? value) =>
    value is List<dynamic> ? value : <dynamic>[];

String? asString(Object? value) => value is String ? value : value?.toString();

int? asInt(Object? value) =>
    value is num ? value.toInt() : int.tryParse('$value');

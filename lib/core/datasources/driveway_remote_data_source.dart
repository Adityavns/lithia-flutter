abstract class DrivewayRemoteDataSource {
  Future<Map<String, dynamic>> query(
    String query,
    Map<String, dynamic> variables,
  );
}

import 'package:get_it/get_it.dart';

import '../domain/usecases/fetch_makes_use_case.dart';
import '../domain/usecases/search_vehicles_use_case.dart';
import '../presentation/inventory/cubit/inventory_cubit.dart';
import 'datasources/driveway_remote_data_source.dart';
import 'datasources/driveway_remote_data_source_impl.dart';
import 'repositories/driveway_repository.dart';
import 'repositories/driveway_repository_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<DrivewayRemoteDataSource>(
    () => DrivewayRemoteDataSourceImpl(
      subscriptionKey: const String.fromEnvironment('DRIVEWAY_API_KEY'),
    ),
  );
  getIt.registerLazySingleton<DrivewayRepository>(
    () => DrivewayRepositoryImpl(getIt<DrivewayRemoteDataSource>()),
  );
  getIt.registerLazySingleton<FetchMakesUseCase>(
    () => FetchMakesUseCaseImpl(getIt<DrivewayRepository>()),
  );
  getIt.registerLazySingleton<SearchVehiclesUseCase>(
    () => SearchVehiclesUseCaseImpl(getIt<DrivewayRepository>()),
  );
  getIt.registerFactory<InventoryCubit>(
    () => InventoryCubit(
      fetchMakesUseCase: getIt<FetchMakesUseCase>(),
      searchVehiclesUseCase: getIt<SearchVehiclesUseCase>(),
    ),
  );
}

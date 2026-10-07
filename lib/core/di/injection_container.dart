import 'package:bloc_test_demo/core/network/dio_client_2nd.dart';
import 'package:bloc_test_demo/core/theme/bloc/theme_cubit.dart';
import 'package:bloc_test_demo/features/home/data/datasourch/signin_remote_datasourch.dart';
import 'package:bloc_test_demo/features/home/data/repositores/signin_repositores_impl.dart';
import 'package:bloc_test_demo/features/home/domin/repositores/sigin_repositores.dart';
import 'package:bloc_test_demo/features/home/domin/usecash/signin_useca.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_bloc.dart';
import 'package:bloc_test_demo/features/larn_hive/data/datasources/larn_hive_local_datasource.dart';
import 'package:bloc_test_demo/features/larn_hive/data/repositories/larn_hive_repository_impl.dart';
import 'package:bloc_test_demo/features/larn_hive/domain/repositories/larn_hive_repository.dart';
import 'package:bloc_test_demo/features/larn_hive/domain/usecases/larn_hive_usecase.dart';
import 'package:bloc_test_demo/features/larn_hive/presentation/bloc/larn_hive_bloc.dart';
import 'package:bloc_test_demo/features/larn_sqlite/data/datasources/sqlite_local_datasource.dart';
import 'package:bloc_test_demo/features/larn_sqlite/data/repositories/sqlite_repository_impl.dart';
import 'package:bloc_test_demo/features/larn_sqlite/domain/repositories/sqlite_repository.dart';
import 'package:bloc_test_demo/features/larn_sqlite/domain/usecases/sqlite_usecase.dart';
import 'package:bloc_test_demo/features/larn_sqlite/presentation/bloc/sqlite_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core / Network
  sl.registerLazySingleton(() => DioClient2nd());

  // Core / Theme
  sl.registerLazySingleton(() => ThemeCubit());

  // HOME FEATURE 
  // Bloc
  sl.registerFactory(() => SignInBloc(signinUseca: sl()));

  // Usecase
  sl.registerLazySingleton(() => SigninUseca(signInRepository: sl()));

  // Datasource
  sl.registerLazySingleton<SigninRemoteDatasourch>(
    () => SignRemoteDataSourceImpl(dioClient2nd: sl()),
  );

  // Repository
  sl.registerLazySingleton<SignInRepository>(
    () => SigninRepositoresImpl(signinRemoteDatasourch: sl()),
  );

  // LARN HIVE FEATURE 
  // Bloc
  sl.registerFactory(
    () => LarnHiveBloc(
      getItemsUseCase: sl(),
      addItemUseCase: sl(),
      updateItemUseCase: sl(),
      deleteItemUseCase: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetLarnHiveItemsUseCase(sl()));
  sl.registerLazySingleton(() => AddLarnHiveItemUseCase(sl()));
  sl.registerLazySingleton(() => UpdateLarnHiveItemUseCase(sl()));
  sl.registerLazySingleton(() => DeleteLarnHiveItemUseCase(sl()));

  // Local Datasource
  sl.registerLazySingleton<LarnHiveLocalDataSource>(
    () => LarnHiveLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<LarnHiveRepository>(
    () => LarnHiveRepositoryImpl(localDataSource: sl()),
  );

  //  LARN SQLITE FEATURE 
  // Bloc
  sl.registerFactory(
    () => SqliteBloc(
      getItemsUseCase: sl(),
      addItemUseCase: sl(),
      updateItemUseCase: sl(),
      deleteItemUseCase: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetSqliteItemsUseCase(sl()));
  sl.registerLazySingleton(() => AddSqliteItemUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSqliteItemUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSqliteItemUseCase(sl()));

  // Local Datasource
  sl.registerLazySingleton<SqliteLocalDataSource>(
    () => SqliteLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<SqliteRepository>(
    () => SqliteRepositoryImpl(localDataSource: sl()),
  );
}
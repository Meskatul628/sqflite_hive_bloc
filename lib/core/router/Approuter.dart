import 'package:bloc_test_demo/core/di/injection_container.dart' as di;
import 'package:bloc_test_demo/core/router/AppRoutes.dart';
import 'package:bloc_test_demo/core/router/app_route_obsever.dart';
import 'package:bloc_test_demo/features/larn_hive/presentation/bloc/larn_hive_bloc.dart';
import 'package:bloc_test_demo/features/larn_hive/presentation/pages/larn_hive_page.dart';
import 'package:bloc_test_demo/features/larn_sqlite/presentation/bloc/sqlite_bloc.dart';
import 'package:bloc_test_demo/features/larn_sqlite/presentation/pages/sqlite_page.dart';
import 'package:bloc_test_demo/features/home/presentation/bloc/home_bloc.dart';
import 'package:bloc_test_demo/features/home/presentation/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Approuter {
  static GoRouter goRoute = GoRouter(
    observers: [AppRouteObsever()],
    initialLocation: Approutes.home,
    routes: [
      GoRoute(
        path: Approutes.home,
        name: Approutes.homeName,
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<SignInBloc>(),
          child: Home(),
        ),
      ),
      GoRoute(
        path: Approutes.larnHive,
        name: Approutes.larnHiveName,
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<LarnHiveBloc>(),
          child: const LarnHivePage(),
        ),
      ),
      GoRoute(
        path: Approutes.sqlite,
        name: Approutes.sqliteName,
        builder: (context, state) => BlocProvider(
          create: (context) => di.sl<SqliteBloc>(),
          child: const SqlitePage(),
        ),
      ),
    ],
  );
}
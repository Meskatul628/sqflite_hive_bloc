import 'package:bloc_test_demo/core/router/Approuter.dart';
import 'package:bloc_test_demo/core/theme/app_theme.dart';
import 'package:bloc_test_demo/core/theme/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox('larn_hive_box'),
    Hive.openBox('settings_box'),
  ]);

  // 2. Dependency Injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => di.sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Flutter Enterprise App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: Approuter.goRoute,
          );
        },
      ),
    );
  }
}

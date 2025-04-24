import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/core/di/di.dart' as di;
import 'package:gutendex/core/utils/bloc_observer.dart';
import 'config/routes/router.dart';
import 'config/routes/routes.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
  di.init(),
  ]);
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gutendex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.generateRoute,
      home: null,
    );
  }
}


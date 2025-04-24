
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/config/routes/routes.dart';
import 'package:gutendex/features/book/presentation/cubit/books_cubit.dart';
import 'package:gutendex/features/book/presentation/pages/books_screen.dart';
import 'package:gutendex/features/book/presentation/pages/search_screen.dart';
import '../../core/di/di.dart';
import '../../features/splash/splash_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.booksScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => sl<BooksCubit>()..getBooks(),
              child: const BooksScreen()),
        );
      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => sl<BooksCubit>(),
              child: SearchScreen()),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                // style: getMediumStyle(color: Colors.red, fontSize: 14.0),
              ),
            ),
          ),
        );
    }
  }
}
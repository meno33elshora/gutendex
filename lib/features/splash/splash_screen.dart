import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gutendex/config/routes/routes.dart';
import 'package:gutendex/core/resources/color_manager.dart';
import 'package:gutendex/core/style/text_style.dart';
import 'package:gutendex/core/utils/extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.booksScreen);
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.book_outlined , color: ColorManager.primaryColor,size: 100,),
          Text("Gutendex" , style: getBoldStyle(color: Colors.black),),
        ],
      ).center,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}


// ReadMoreText(
// 'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
// trimMode: TrimMode.Line,
// trimLines: 2,
// colorClickableText: Colors.pink,
// trimCollapsedText: 'Show more',
// trimExpandedText: 'Show less',
// moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
// );
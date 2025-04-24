import 'package:flutter/material.dart';
import 'package:gutendex/core/resources/color_manager.dart' show ColorManager;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 30.0,
        width: 30.0,
        child: Center(
          child: CircularProgressIndicator(
            color: ColorManager.greenLight,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gutendex/features/book/domain/entities/book.dart';

import 'card_details_item.dart';

class CardBookWidget extends StatelessWidget {
  final List<ResultsEntity> results;

  const CardBookWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      itemCount: results.length,
      itemBuilder:
          (context, index) => CardDetailsItem(
            index: index,
            results: results,
          ),
    );
  }
}

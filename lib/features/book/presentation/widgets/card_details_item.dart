import 'package:flutter/material.dart';
import 'package:gutendex/core/utils/extensions.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/style/text_style.dart';
import '../../domain/entities/book.dart';

class CardDetailsItem extends StatefulWidget {
  final List<ResultsEntity> results;
  final int index;

  const CardDetailsItem({
    super.key,
    required this.results,
    required this.index,
  });

  @override
  State<CardDetailsItem> createState() => _CardDetailsItemState();
}

class _CardDetailsItemState extends State<CardDetailsItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    final delay = widget.index * 100;

    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) _controller.forward();
    });

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Card(
          margin: EdgeInsets.all(5.0),
          elevation: 0.0,
          color: ColorManager.primaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.results[widget.index].title.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                    color: ColorManager.primaryColor,
                  ).copyWith(fontSize: 14.0),
                ),
                10.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.2,
                      width: MediaQuery.sizeOf(context).width * 0.25,
                      child: Image.network(
                        widget.results[widget.index].formats.imageJpeg.toString(),
                        isAntiAlias: true,
                        fit: BoxFit.fill,
                        loadingBuilder: (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image).center;
                        },
                      ),
                    ),
                    15.pw,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "📌 Address ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getSemiBoldStyle(
                              color: ColorManager.secondaryColor,
                            ).copyWith(fontSize: 12.0),
                          ),
                          3.ph,
                          ...List.generate(
                            widget.results[widget.index].subjects.length,
                            (i) => Text(
                              "${i + 1} - ${widget.results[widget.index].subjects[i]}",
                              style: getRegularStyle(
                                color: Colors.black,
                              ).copyWith(fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.ph,
                Text(
                  "✍🏻 Authors",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                    color: ColorManager.secondaryColor,
                  ).copyWith(fontSize: 12.0),
                ),
                3.ph,
                ...List.generate(
                  widget.results[widget.index].authors.length,
                  (i) => Text(
                    "${i + 1} - ${widget.results[widget.index].authors[i].name}",

                    style: getRegularStyle(
                      color: Colors.black,
                    ).copyWith(fontSize: 12.0),
                  ),
                ),
                10.ph,
                Text(
                  "📝 Summaries",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getSemiBoldStyle(
                    color: ColorManager.secondaryColor,
                  ).copyWith(fontSize: 12.0),
                ),
                3.ph,
                ...List.generate(
                  widget.results[widget.index].summaries.length,
                  (i) => ReadMoreText(
                    widget.results[widget.index].summaries[i]
                        .toString()
                        .replaceAll("[", "")
                        .replaceAll("]", ""),
                    trimMode: TrimMode.Length,
                    trimLines: 2,
                    colorClickableText: ColorManager.red,

                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: getSemiBoldStyle(
                      color: ColorManager.primaryColor,
                    ).copyWith(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

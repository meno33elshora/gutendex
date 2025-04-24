import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/core/utils/extensions.dart';
import 'package:gutendex/features/book/presentation/widgets/card_book_widget.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/di/di.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/shared/widget/loading_widget.dart';
import '../../../../core/style/text_style.dart';
import '../cubit/books_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) async {
                  await Future.delayed(const Duration(milliseconds: 750));
                  context.read<BooksCubit>().getBooksFromSearch(input: value);
                  setState(() {});
                },
                onTapOutside:
                    (event) => FocusManager.instance.primaryFocus?.unfocus(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search Any Book",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.greenLight),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchController.clear();
                      context.read<BooksCubit>().listOfBooksFromSearch.clear();
                      setState(() {});
                    },
                    icon: Icon(Icons.clear),
                  ),
                  hintStyle: getMediumStyle(
                    color: ColorManager.secondaryColor,
                  ).copyWith(fontSize: 12.0),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BooksCubit, BooksState>(
                builder: (context, state) {
                  var cubit = context.read<BooksCubit>();

                  if (state is LoadingSearchBooksState) {
                    return Center(child: LoadingWidget());
                  } else if (state is ErrorSearchBooksState) {
                    return Text(
                      state.error.toString(),
                      style: getMediumStyle(color: ColorManager.red),
                    );
                  }

                  if (cubit.listOfBooksFromSearch.isEmpty) {
                    return Center(
                      child: Text(
                        "No books found For Search.",
                        style: getBoldStyle(color: ColorManager.primaryColor),
                      ),
                    );
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification &&
                          notification.metrics.pixels >=
                              notification.metrics.maxScrollExtent &&
                          (state is! LoadingSearchPageBooksState)) {
                        context.read<BooksCubit>().getBooksFromSearch(
                          hasMaxReached: true,
                          input: searchController.text,
                        );
                      }

                      return true;
                    },
                    child: Column(
                      children: [
                        CardBookWidget(results: cubit.listOfBooksFromSearch),
                        (state is LoadingSearchPageBooksState)
                            ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LoadingWidget(),
                            )
                            : Container(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

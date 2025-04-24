import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/config/routes/routes.dart';
import 'package:gutendex/core/resources/color_manager.dart';
import 'package:gutendex/core/style/text_style.dart';
import 'package:gutendex/core/utils/extensions.dart';
import 'package:gutendex/features/book/presentation/cubit/books_cubit.dart';
import 'package:gutendex/features/book/presentation/widgets/card_book_widget.dart';
import 'package:readmore/readmore.dart';
import '../../../../core/shared/widget/loading_widget.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  bool search = false;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorManager.primaryColor,
        title:

        Text("Books", style: getMediumStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.pushNamed(context, Routes.searchScreen);
              setState(() {
                search = ! search;
                searchController.clear();
                context.read<BooksCubit>().listOfBooksFromSearch.clear();
              });
            },
            icon: Icon(
                search? Icons.highlight_remove :
                Icons.search, color: Colors.white),
          ),
        ],
        bottom: PreferredSize(preferredSize: Size(double.infinity,search ? 60.0 : 0.0),
            child:search ?
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
            ) : Container() ),
      ),
      body:
      (searchController.text.isNotEmpty)?
      _buildListOfBooksSearchWidget()
       :
      _buildListOfBooksWidget(),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Widget _buildListOfBooksWidget(){
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        var cubit = context.read<BooksCubit>();

        if (state is LoadingBooksState) {
          return Center(child: LoadingWidget());
        } else if (state is ErrorBooksState) {
          return Text(
            state.error.toString(),
            style: getMediumStyle(color: ColorManager.red),
          );
        }
        if (cubit.listOfBooks.isEmpty) {
          return Text(
            "No books found.",
            style: getBoldStyle(color: ColorManager.primaryColor),
          ).center;
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification &&
                notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent &&
                (state is! LoadingPageBooksState)) {
              context.read<BooksCubit>().getBooks(hasMaxReached: true);
            }

            return true;
          },
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                    onRefresh: () => cubit.getBooks(),
                    elevation: 0.0,
                    color: ColorManager.greenLight,
                    child: CardBookWidget(results: cubit.listOfBooks,)),
              ),
              (state is LoadingPageBooksState)
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoadingWidget(),
              )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
  Widget _buildListOfBooksSearchWidget(){
    return BlocBuilder<BooksCubit, BooksState>(
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
    );
  }

}

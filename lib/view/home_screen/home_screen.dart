import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:news_app/controller/home_screen_controller.dart';
import 'package:news_app/view/search_screen/search_screen.dart';
import 'package:news_app/view/widgets/news_card.dart';


class HomeScreen extends StatelessWidget {
  void fetchData(BuildContext context) {
    Provider.of<HomeScreenController>(context, listen: false).fetchData();
  }



  @override
  Widget build(BuildContext context) {
    fetchData(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff29d51d),
          elevation: 0,
          title: const Text(
            "Exclusive News Today",
          ),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 25,
              fontWeight: FontWeight.w600),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            )
          ],
        ),
        body: Consumer<HomeScreenController>(builder: (context, provider, child) {
          return provider.isLoading == true
              ? Center(
              child: LottieBuilder.asset(
                "assets/animation/loading animation.json",
                fit: BoxFit.cover,
                height: 150,
                width: 150,
              ))
              : Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
                itemBuilder: (context, index) => NewsCard(
                  title: provider.newsModel.articles?[index].title.toString() ?? "",
                  description: provider.newsModel.articles?[index].description
                      .toString() ??
                      "",
                  date:
                  provider.newsModel.articles?[index].publishedAt,
                  imageUrl: provider
                      .newsModel.articles?[index].urlToImage
                      .toString() ??
                      "",
                  contant: provider.newsModel.articles?[index].content
                      .toString() ??
                      "",
                  sourceName: provider
                      .newsModel.articles?[index].source?.name
                      .toString() ??
                      "",
                  url: provider.newsModel.articles?[index].url
                      .toString() ??
                      "",
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: 20,
                ),
                itemCount: provider.newsModel.articles?.length ?? 0),
          );
        }));

  }
}

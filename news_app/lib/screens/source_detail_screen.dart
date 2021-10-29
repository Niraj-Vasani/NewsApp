import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:expandable_text/expandable_text.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/source_detail_cubit/get_source_news_cubit.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/source_model.dart';

class SourceDetail extends StatefulWidget {
  final Sources source;

  const SourceDetail({Key? key, required this.source}) : super(key: key);

  @override
  _SourceDetailState createState() => _SourceDetailState();
}

class _SourceDetailState extends State<SourceDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.source.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber[900],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              color: Colors.amber[900],
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    widget.source.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<GetSourceNewsCubit, GetSourceNewsState>(
                  builder: (context, state) {
                    if (state is GetSourceNewsInitial) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeWidth: 6,
                        ),
                      );
                    } else if (state is GetSourceNewsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.redAccent,
                          strokeWidth: 6,
                        ),
                      );
                    } else if (state is GetSourceNewsLoaded) {
                      final articles = state.articles;
                      return _buildSourceNews(context, articles, widget.source);
                    }
                    return Center(child: Text("Coudn't connect to server!!"));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildSourceNews(
    BuildContext context, List<Articles> articles, Sources source) {
  if (articles.length == 0) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("No Articles"),
        ],
      ),
    );
  } else {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 20,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/img/placeholder.jpg",
                  image: articles[index].urlToImage ??
                      "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
                  fit: BoxFit.fill,
                  width: double.maxFinite,
                ),
              ),
              Container(
                color: Colors.grey[100],
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articles[index].title ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    ExpandableText(
                      articles[index].content,
                      expandText: "show more",
                      collapseText: "show less",
                      linkColor: Colors.amber[900],
                      maxLines: 3,
                      animation: true,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Text(
                            timeAgo(
                              DateTime.parse(articles[index].publishedAt),
                            ),
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

String timeAgo(DateTime date) {
  return timeago.format(date, allowFromNow: true, locale: 'en');
}

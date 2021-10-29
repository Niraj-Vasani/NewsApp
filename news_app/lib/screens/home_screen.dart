import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/home_screen_cubit/get_sources_cubit.dart';
import 'package:news_app/cubit/source_detail_cubit/get_source_news_cubit.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/networking/api_request.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/screens/source_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[100],
        appBar: AppBar(
          backgroundColor: Colors.amber[900],
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "News Bloggers",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: BlocBuilder<GetSourcesCubit, GetSourcesState>(
            builder: (context, state) {
              if (state is GetSourcesInitial) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber[900],
                    strokeWidth: 6,
                  ),
                );
              } else if (state is GetSourcesLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber,
                    strokeWidth: 6,
                  ),
                );
              } else if (state is GetSourcesLoaded) {
                final sources = state.sources;
                return _buildNewsBloggers(context, sources);
              }
              return Center(
                child: Text("Coudn't connect to server!!"),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildNewsBloggers(BuildContext context, List<Sources> sources) {
  if (sources.length == 0) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text("No Sources"),
        ],
      ),
    );
  } else {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: sources.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 2.5, bottom: 2.5),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 3,
              primary: Colors.white,
              onPrimary: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) {
                      final NewsRepository _repository = NewsRepository(apiRequest: ApiRequest(Dio(), sourceId: sources[index].id));
                      return GetSourceNewsCubit(_repository);
                    },
                    child: SourceDetail(
                      source: sources[index],
                    ),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: ListTile(
                title: Text(
                  sources[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    sources[index].category,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

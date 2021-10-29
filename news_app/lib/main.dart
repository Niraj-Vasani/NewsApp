import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/home_screen_cubit/get_sources_cubit.dart';
import 'package:news_app/networking/api_request.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewsRepository _repository = NewsRepository(apiRequest: ApiRequest(Dio()));

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.amber[900],
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: BlocProvider(
        create: (context) {
          return GetSourcesCubit(_repository);
        },
        child: HomeScreen(),
      ),
    );
  }
}

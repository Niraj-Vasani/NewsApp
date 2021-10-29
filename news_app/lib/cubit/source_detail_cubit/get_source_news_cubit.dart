import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/repositories/news_repository.dart';

part 'get_source_news_state.dart';

class GetSourceNewsCubit extends Cubit<GetSourceNewsState> {
  final NewsRepository _repository;

  GetSourceNewsCubit(this._repository) : super(GetSourceNewsInitial()) {
    _getSourceNews();
  }

  void _getSourceNews() async {
    try {
      emit(GetSourceNewsLoading());

      ArticleResponse response = await _repository.apiRequest.getSourceNews();
      List<Articles> aricles = response.articles;

      emit(GetSourceNewsLoaded(articles: aricles));
    } catch (e) {
      print(e);
    }
  }
}

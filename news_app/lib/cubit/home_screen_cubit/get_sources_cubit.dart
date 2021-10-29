import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/repositories/news_repository.dart';

part 'get_sources_state.dart';

class GetSourcesCubit extends Cubit<GetSourcesState> {
  final NewsRepository _repository;

  GetSourcesCubit(this._repository) : super(GetSourcesInitial()){
    _getSources();
  }

  void _getSources() async {
    try {
      emit(GetSourcesLoading());

      SourceResponse response = await _repository.apiRequest.getSources();
      List<Sources> sources = response.sources;

      emit(GetSourcesLoaded(sources: sources));
    } catch (e) {
      print(e);
    }
  }
}

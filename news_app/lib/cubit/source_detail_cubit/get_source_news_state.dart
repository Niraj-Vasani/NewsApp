part of 'get_source_news_cubit.dart';

@immutable
abstract class GetSourceNewsState {}

class GetSourceNewsInitial extends GetSourceNewsState {}

class GetSourceNewsLoading extends GetSourceNewsState {}

class GetSourceNewsLoaded extends GetSourceNewsState {
  final List<Articles> articles;

  GetSourceNewsLoaded({required this.articles});
}

class GetSourceNewsError extends GetSourceNewsState {
  final AlertDialog alertDialog;

  GetSourceNewsError(this.alertDialog);
}

part of 'get_sources_cubit.dart';

@immutable
abstract class GetSourcesState {}

class GetSourcesInitial extends GetSourcesState {}

class GetSourcesLoading extends GetSourcesState {}

class GetSourcesLoaded extends GetSourcesState {
  final List<Sources> sources;

  GetSourcesLoaded({required this.sources});
}

class GetSourcesError extends GetSourcesState {
  final AlertDialog alertDialog;

  GetSourcesError({required this.alertDialog});
}

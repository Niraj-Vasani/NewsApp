import 'package:dio/dio.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:retrofit/http.dart';
part 'api_request.g.dart';

@RestApi(baseUrl: "https://newsapi.org")
abstract class ApiRequest {
  factory ApiRequest(Dio dio, {String? baseUrl, String? sourceId}) {
    dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: true,
        responseHeader: true,
      ),
    );

    dio.options = BaseOptions(
      receiveTimeout: 30000,
      connectTimeout: 30000,
      queryParameters: {
        "apiKey": "691454d43c474819a7f7dce274930ee6",
        "sources": sourceId ?? "",
      },
    );
    return _ApiRequest(dio, baseUrl: baseUrl);
  }

  @GET("/v2/top-headlines/sources")
  Future<SourceResponse> getSources();

  @GET("/v2/top-headlines")
  Future<ArticleResponse> getSourceNews();
}

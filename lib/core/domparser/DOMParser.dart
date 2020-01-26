import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:html/parser.dart';

class DOMParser {
  static Future<String> getRichText(String URL) {
    Dio dio = Dio();
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://www.animexx.de")).interceptor);
    return dio.get(
        URL,
        options: buildCacheOptions(
            Duration(minutes: 5),
            maxStale: Duration(hours: 12),
            options: Options(
                responseType: ResponseType.plain
            )
        )
    ).then((res) {
      var dom = HtmlParser(res.data).parse();
      var info = dom.querySelector("#seite-1");

      return info.text;
    });
  }
}

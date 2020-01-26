import 'package:anifly/core/serialization/AnimexxData.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class AnimexxDataService {

  static const API_URL = "https://www.animexx.de/events/ajax/filter";

  static Future<AnimexxData> getEventData() {
    var defaultFormData = {
      "filter[includePast]": false,
      "filter[onlyHighlights]": true
    };
    Dio dio = Dio();
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://www.animexx.de")).interceptor);
    return dio.post(
        API_URL,
        data: FormData.fromMap(defaultFormData),
        options: buildCacheOptions(
            Duration(minutes: 50),
            maxStale: Duration(minutes: 30),
            options: Options(
                responseType: ResponseType.json
            )
        )
    ).then((res) {
      return AnimexxData.fromJson(res.data);
    });
  }
}

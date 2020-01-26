import 'package:flutter/material.dart';

class URLBuilderService {
  final int id;
  final String slug;
  
  URLBuilderService({
    @required this.id,
    @required this.slug
  });

  String generateURL() {
    return "https://www.animexx.de/events/" + id.toString() + "/" + slug;
  }
}

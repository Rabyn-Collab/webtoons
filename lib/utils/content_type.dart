import 'package:webtoons/services/anime_parsers/gogoanime_parser.dart';
import 'package:webtoons/services/base_parser.dart';
import 'package:webtoons/services/manga_parsers/mangasee_parser.dart';

enum ContentType {
  anime,
  manga,
}

BaseParser chooseProvider(ContentType type) {
  if (type == ContentType.anime) {
    return GogoanimeParser();
  } else {
    return MangaSeeParser();
  }
}

import 'package:webtoons/models/entry_info.dart';
import 'package:webtoons/utils/content_type.dart' as contype;
import 'package:web_scraper/web_scraper.dart';

abstract class BaseParser {
  final String domain;
  final String queryPopular;
  final String querySearch;
  final contype.ContentType contentType;
  late WebScraper webScraper;

  BaseParser({
    required this.domain,
    required this.queryPopular,
    required this.querySearch,
    required this.contentType,
  }) {
    webScraper = WebScraper(domain);
  }

  Future<List<EntryInfo>> getGridData(String url, int page);

  Future<EntryInfo?> getDetailsData(EntryInfo info);

  Future<EntryInfo?> getContentData(EntryInfo info);

  Future<Episode> getViewerInfo(Episode episode, [EntryInfo? info]);
}

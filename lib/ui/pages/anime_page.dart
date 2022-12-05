import 'package:flutter/material.dart';
import 'package:webtoons/models/entry_info.dart';
import 'package:webtoons/ui/widgets/grid.dart';
import 'package:webtoons/utils/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:webtoons/utils/content_type.dart' as contype;

class AnimePage extends StatefulWidget {
  const AnimePage({Key? key}) : super(key: key);

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  @override
  void dispose() {
    Hive.box('animeEntries').close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anime')),
      body: ValueListenableBuilder<Box<EntryInfo>>(
        valueListenable: Boxes.getAnimeEntries().listenable(),
        builder: (context, value, child) {
          final entries =
              value.values.where((element) => element.favorite).toList();

          if (entries.isNotEmpty) {
            return GridLibrary(
              urlQuery: '',
              gridParser: contype.chooseProvider(contype.ContentType.anime),
              customEntries: entries,
              key: UniqueKey(),
            );
          }
          return const Center(child: Text('Empty...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'discover_anime_btn',
        onPressed: () {
          Navigator.of(context).pushNamed(
            '/discover',
            arguments: contype.ContentType.anime,
          );
        },
        child: const Icon(Icons.explore),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:simplecrudctej/models/songs_class.dart';

class SongsListPage extends StatefulWidget {
  const SongsListPage({Key? key}) : super(key: key);

  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  final List<Song> songs = sampleSongs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.library_music_outlined),
          title: const Text('Simple CRUD',
              style: TextStyle(fontWeight: FontWeight.w300))),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading:
                Icon(Icons.audiotrack_outlined, color: Colors.grey.shade800),
            title: Text(songs[index].title),
            subtitle: Text(
              '${songs[index].artists} • ${getTimeFromSecongs(songs[index].duration)}',
              style: TextStyle(color: Colors.grey.shade800),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

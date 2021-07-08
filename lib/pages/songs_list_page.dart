import 'package:flutter/material.dart';
import 'package:simplecrudctej/Pages/song_form_page.dart';
import 'package:simplecrudctej/models/songs_class.dart';
import 'package:simplecrudctej/utils/song_list_page_utils.dart';

class SongsListPage extends StatefulWidget {
  const SongsListPage({Key? key}) : super(key: key);

  @override
  State<SongsListPage> createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  List<Song> songs = sampleSongs;

  updateSongs() {
    getSongsList().then((value) {
      setState(() {
        songs = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    updateSongs();

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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 20.0,
                    color: Colors.brown[900],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SongsFormPage(song: songs[index])),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20.0,
                    color: Colors.brown[900],
                  ),
                  onPressed: () {
                    // set up the buttons
                    Widget cancelButton = TextButton(
                      child: const Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                    Widget continueButton = TextButton(
                      child: const Text("Yes"),
                      onPressed: () {
                        deleteSong(songs[index].id);
                        updateSongs();
                        Navigator.of(context).pop();
                      },
                    );
                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: const Text("Confirm"),
                      content: Text(
                          'Are you sure you want to delete "${songs[index].title}"?'),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );
                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SongsFormPage(song: null)),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

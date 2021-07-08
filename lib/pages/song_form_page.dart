import 'package:flutter/material.dart';
import 'package:simplecrudctej/models/songs_class.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:simplecrudctej/pages/songs_list_page.dart';
import 'package:simplecrudctej/utils/song_form_page_utils.dart';

class SongsFormPage extends StatefulWidget {
  const SongsFormPage({Key? key, required this.song}) : super(key: key);

  final Song? song;

  @override
  State<SongsFormPage> createState() => _SongsFormPageState();
}

class _SongsFormPageState extends State<SongsFormPage> {
  final _formKey = GlobalKey<FormState>();
  var maskFormatter =
      MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  final artistController = TextEditingController();
  final titleController = TextEditingController();
  final durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.song != null) {
      titleController.text = widget.song!.title;
      artistController.text = widget.song!.artists;
      durationController.text = getTimeFromSecongs(widget.song!.duration);
    }

    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.library_music_outlined),
          title: const Text('Simple CRUD',
              style: TextStyle(fontWeight: FontWeight.w300)),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: ListTile(
                  title: Text(
                    'Song Form',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.audiotrack_outlined,
                    color: Colors.grey.shade800),
                title: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.supervised_user_circle_outlined,
                    color: Colors.grey.shade800),
                title: TextField(
                  controller: artistController,
                  decoration: const InputDecoration(
                    hintText: "Artist(s)",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Colors.grey.shade800,
                ),
                title: TextField(
                  controller: durationController,
                  inputFormatters: [maskFormatter],
                  decoration: const InputDecoration(
                    hintText: "Duration",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(fit: StackFit.expand, children: [
          Positioned(
            right: 30,
            bottom: 20,
            child: FloatingActionButton.extended(
              heroTag: "saveBtn",
              onPressed: () async {
                Song toSend;
                if (widget.song == null) {
                  toSend = Song(
                    title: titleController.text,
                    artists: artistController.text,
                    duration: getSecondsFromTime(maskFormatter.getMaskedText()),
                  );
                } else {
                  toSend = widget.song!.copy(
                    title: titleController.text,
                    artists: artistController.text,
                    duration: getSecondsFromTime(maskFormatter.getMaskedText()),
                  );
                }

                var id = await saveSong(toSend);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content:
                          Text((id! > 0) ? 'Song has been saved.' : 'Error'),
                    );
                  },
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SongsListPage()),
                );
              },
              label: const Text('Save'),
              icon: const Icon(Icons.save_outlined),
              backgroundColor: Colors.green.shade700,
            ),
          ),
          Positioned(
            left: 30,
            bottom: 20,
            child: FloatingActionButton.extended(
              heroTag: "cancelBtn",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SongsListPage()),
                );
              },
              backgroundColor: Colors.grey.shade500,
              label: const Text('Cancel'),
              icon: const Icon(Icons.close),
            ),
          )
        ]));
  }
}

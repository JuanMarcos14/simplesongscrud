import 'package:simplecrudctej/models/database.dart';
import 'package:simplecrudctej/models/songs_class.dart';

Future<int?> saveSong(Song? song) async {
  if (song == null) {
    return 0;
  }

  int songId = 0;
  if (song.id == null) {
    var createdSong = await SongsDatabase.instance.create(song);
    songId = createdSong.id!;
  } else {
    songId = await SongsDatabase.instance.update(song);
  }

  return songId;
}

import 'package:simplecrudctej/models/database.dart';
import 'package:simplecrudctej/models/songs_class.dart';

Future<List<Song>> getSongsList() async {
  return await SongsDatabase.instance.readAllSong();
}

Future<int> deleteSong(int? id) async {
  return await SongsDatabase.instance.delete(id!);
}

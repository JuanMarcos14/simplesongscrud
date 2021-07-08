const String tableSongs = 'songs';

class SongFields {
  static final List<String> values = [id, title, artists, duration];

  static const String id = '_id';
  static const String title = '_title';
  static const String artists = '_artists';
  static const String duration = '_duration';
}

class Song {
  final int? id;
  final String title;
  final String artists;
  final int duration;

  Song({
    this.id,
    required this.title,
    required this.artists,
    required this.duration,
  });

  Song copy({
    int? id,
    String? title,
    String? artists,
    int? duration,
  }) =>
      Song(
        id: id ?? this.id,
        title: title ?? this.title,
        artists: artists ?? this.artists,
        duration: duration ?? this.duration,
      );

  Map<String, Object?> toJson() => {
        SongFields.id: id,
        SongFields.title: title,
        SongFields.artists: artists,
        SongFields.duration: duration,
      };

  static Song fromJson(Map<String, Object?> json) => Song(
        id: json[SongFields.id] as int,
        title: json[SongFields.title] as String,
        artists: json[SongFields.artists] as String,
        duration: json[SongFields.duration] as int,
      );
}

List<Song> sampleSongs = [
  Song(id: 1, title: 'Salute', artists: 'Little Mix', duration: 237),
  Song(
      id: 2,
      title: 'Met Him Last Night (feat. Ariana Grande)',
      artists: 'Demi Lovato ft. Ariana Grande',
      duration: 205)
];

String getTimeFromSecongs(int seconds) {
  var d = Duration(seconds: seconds);
  List<String> parts = d.toString().split(':');
  return '${parts[1]}:${parts[2].split('.')[0]}';
}

int getSecondsFromTime(String time) {
  var minutesAndSeconds = time.split(':');
  var m2S = int.parse(minutesAndSeconds[0]) * 60;
  var seconds = m2S + int.parse(minutesAndSeconds[1]);
  return seconds;
}

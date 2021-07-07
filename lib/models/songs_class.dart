class Song {
  final int id;
  final String title;
  final String artists;
  final int duration;

  Song({
    required this.id,
    required this.title,
    required this.artists,
    required this.duration,
  });
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

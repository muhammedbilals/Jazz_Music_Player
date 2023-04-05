import 'package:hive/hive.dart';
part 'favourites.g.dart';

@HiveType(typeId: 3)
class favourites  extends HiveObject{
  @HiveField(0)
  String? songname;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  favourites(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.id});
}
String boxname3 = 'favourites';

class favocuritesbox {
  static Box<favourites>? _box;
  static Box<favourites> getInstance() {
    return _box ??= Hive.box(boxname3);
  }
}
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/logic/allsongs/all_songs_bloc.dart';
import 'package:music_player/logic/bloc/mostplayed_bloc.dart';
import 'package:music_player/logic/favourites/favourites_bloc.dart';
import 'package:music_player/logic/playlist/playlist_bloc.dart';
import 'package:music_player/logic/recentlyplayed/recentlyplayed_bloc.dart';
import 'package:music_player/model/favourites.dart';
import 'package:music_player/model/mostplayed.dart';
import 'package:music_player/model/playlistmodel.dart';
import 'package:music_player/model/recentlyplayed.dart';
import 'package:music_player/model/songmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/screens/mainhome/functions/addToFavourites.dart';
import 'package:music_player/screens/splash.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsWidget extends StatefulWidget {
  const AllSongsWidget({super.key});

  @override
  State<AllSongsWidget> createState() => _AllSongsWidgetState();
}

final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
final songbox = SongBox.getInstance();
final box4 = favocuritesbox.getInstance();
final List<MostPlayed> mostplayedsong = mostbox.values.toList();
final playlistbox = PlaylistSongsbox.getInstance();

class _AllSongsWidgetState extends State<AllSongsWidget> {
  bool istaped = true;

  List<Audio> convertAudios = [];

  @override
  void initState() {
    List<Songs> dbsongs = songbox.values.toList();
    for (var item in dbsongs) {
      convertAudios.add(
        Audio.file(
          item.songurl!,
          metas: Metas(
            title: item.songname,
            artist: item.artist,
            id: item.id.toString(),
          ),
        ),
      );
    }
    super.initState();
  }
  @override
    void dispose() {
      audioPlayer.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    double vheight = MediaQuery.of(context).size.height;
    

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5, bottom: 5),
              child: Text('All Songs',
                  style: GoogleFonts.kanit(fontSize: 20, color: colorwhite)),
            ),
          ],
        ),
        BlocBuilder<AllSongsBloc, AllSongsState>(
          builder: (context, state) {
            if (state is AllSongsInitial) {
              context.read<AllSongsBloc>().add(FetchAllSongs());
            }
            if (state is DisplayAllSongs) {
              return state.Allsongs.isNotEmpty
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.Allsongs.length,
                      itemBuilder: ((context, songindex) {
                        RecentlyPlayed rsongs;
                        // Songs songs = state.Allsongs[songindex];
                        MostPlayed mostsong = mostplayedsong[songindex];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 5),
                          child: ListTile(
                            onTap: () {
                              audioPlayer.open(
                                Playlist(
                                    audios: convertAudios,
                                    startIndex: songindex),
                                headPhoneStrategy:
                                    HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                                showNotification: true,
                              );
                              rsongs = RecentlyPlayed(
                                  id: state.Allsongs[songindex].id,
                                  artist: state.Allsongs[songindex].artist,
                                  duration: state.Allsongs[songindex].duration,
                                  songname: state.Allsongs[songindex].songname,
                                  songurl: state.Allsongs[songindex].songurl,
                                  index: songindex);
                              BlocProvider.of<RecentlyplayedBloc>(context)
                                  .add(AddToRecentlyPlayed(rsongs));

                              context.read<MostplayedBloc>().add(
                                  UpdateMostPlayedCount(mostsong, songindex));
                            },
                            leading: QueryArtworkWidget(
                              artworkHeight: vheight * 0.06,
                              artworkWidth: vheight * 0.06,
                              keepOldArtwork: true,
                              artworkBorder: BorderRadius.circular(10),
                              id: state.Allsongs[songindex].id!,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/music.jpeg',
                                  height: vheight * 0.06,
                                  width: vheight * 0.06,
                                ),
                              ),
                            ),
                            title: Text(
                              state.Allsongs[songindex].songname!,
                              style: GoogleFonts.kanit(color: colorwhite),
                            ),
                            subtitle: Text(
                                state.Allsongs[songindex].artist ?? "No Artist",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.kanit(
                                    color: colorwhite.withOpacity(0.7),
                                    fontSize: 12)),
                            trailing: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                IconButton(onPressed: () {
                                  BlocProvider.of<FavouritesBloc>(context).add(
                                      AddorRemoveFavourites(
                                          favourites(
                                              songname: state
                                                  .Allsongs[songindex]
                                                  .songname??"No Name",
                                              artist: state
                                                  .Allsongs[songindex].artist??"No Artist",
                                              duration: state
                                                  .Allsongs[songindex]
                                                  .duration??0,
                                              songurl: state
                                                  .Allsongs[songindex].songurl!,
                                              id: state
                                                  .Allsongs[songindex].id!),
                                          songindex));
                                }, icon: BlocBuilder<FavouritesBloc,
                                    FavouritesState>(
                                  builder: (context, state) {
                                    return Icon(Icons.favorite,
                                        color: (checkFavoriteStatus(songindex))
                                            ? Color.fromARGB(255, 85, 85, 85)
                                            : Color.fromARGB(
                                                255, 255, 255, 255));
                                  },
                                )),
                                IconButton(
                                  onPressed: () {
                                    showPlaylistOptions(context, songindex);
                                  },
                                  icon: const Icon(Icons.playlist_add),
                                  color: colorwhite,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  : Text('data');
            }
            return Text('data');
          },
        )
      ],
    );
  }
}

showPlaylistOptions(BuildContext context, int songindex) {
  final box = PlaylistSongsbox.getInstance();
  double vwidth = MediaQuery.of(context).size.width;
  final myController = TextEditingController();
  playlistbox.isNotEmpty
      ? showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: colorextralight,
                alignment: Alignment.bottomCenter,
                content: Container(
                  height: 200,
                  width: vwidth,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<Box<PlaylistSongs>>(
                            valueListenable: box.listenable(),
                            builder: (context, Box<PlaylistSongs> playlistsongs,
                                child) {
                              List<PlaylistSongs> playlistsong =
                                  playlistsongs.values.toList();
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: playlistsong.length,
                                itemBuilder: ((context, index) {
                                  return ListTile(
                                    onTap: () {
                                      PlaylistSongs? playsongs =
                                          playlistsongs.getAt(index);
                                      List<Songs> playsongdb =
                                          playsongs!.playlistssongs!;
                                      List<Songs> songdb =
                                          songbox.values.toList();
                                      bool isAlreadyAdded = playsongdb.any(
                                          (element) =>
                                              element.id ==
                                              songdb[songindex].id);
                                      if (!isAlreadyAdded) {
                                        playsongdb.add(
                                          Songs(
                                            songname:
                                                songdb[songindex].songname,
                                            artist: songdb[songindex].artist,
                                            duration:
                                                songdb[songindex].duration,
                                            songurl: songdb[songindex].songurl,
                                            id: songdb[songindex].id,
                                          ),
                                        );
                                      }
                                      playlistsongs.putAt(
                                          index,
                                          PlaylistSongs(
                                              playlistname: playlistsong[index]
                                                  .playlistname,
                                              playlistssongs: playsongdb));
                                      Navigator.pop(context);
                                    },
                                    title: Text(
                                      playlistsong[index].playlistname!,
                                      style:
                                          GoogleFonts.kanit(color: colorblack),
                                    ),
                                  );
                                }),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      : showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: colorextralight,
            alignment: Alignment.bottomCenter,
            content: Container(
              height: 250,
              width: vwidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'Create Playlist',
                            style: GoogleFonts.kanit(
                                fontSize: 25, color: colorblack),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: vwidth * 0.90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: colorlight,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  cursorColor: colordark,
                                  controller: myController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    label: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        'Enter Playlist Name:',
                                        style: GoogleFonts.kanit(
                                            fontSize: 20,
                                            color: colorblack.withOpacity(0.5)),
                                      ),
                                    ),
                                    // alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: vwidth * 0.40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: colorlight,
                              ),
                              child: TextButton.icon(
                                icon: const Icon(
                                  Icons.close,
                                  color: colorblack,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                label: Text(
                                  'Cancel',
                                  style: GoogleFonts.kanit(
                                      fontSize: 20, color: colorblack),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: vwidth * 0.43,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: colorlight,
                              ),
                              child: TextButton.icon(
                                icon: const Icon(
                                  Icons.done,
                                  color: colorblack,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // createplaylist(myController.text)
                                  BlocProvider.of<PlaylistBloc>(context)
                                      .add(CreatePlaylist(myController.text));
                                },
                                label: Text(
                                  'Done',
                                  style: GoogleFonts.kanit(
                                      fontSize: 20, color: colorblack),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
}

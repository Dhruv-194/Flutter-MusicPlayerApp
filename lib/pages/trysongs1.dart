import 'package:flutter/material.dart';
import 'package:minimal_music_player_app/components/my_drawer.dart';
import 'package:minimal_music_player_app/models/song.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:minimal_music_player_app/pages/mainsongpage.dart';

class TrySongs1 extends StatefulWidget {
  const TrySongs1({Key? key}) : super(key: key);

  @override
  _TrySongs1State createState() => _TrySongs1State();
}

class _TrySongs1State extends State<TrySongs1> {
  // Main method.
  final OnAudioQuery _audioQuery = OnAudioQuery();

  // Indicate if application has permission to the library.
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    // (Optinal) Set logging level. By default will be set to 'WARN'.
    //
    // Log will appear on:
    //  * XCode: Debug Console
    //  * VsCode: Debug Console
    //  * Android Studio: Debug and Logcat Console
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();
    querySongs();
    print("pls-" + _playlist.toString());
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }

List<SongModel> songs = [];
final List<Song> _playlist = [];
 Future <List<Song>> querySongs () async {
  print("query??");
   songs = await _audioQuery.querySongs(   sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,);
     var i =0;
    for(var ele in songs) {
       _playlist[i]= Song(artistName: songs[i].artist!, songName: songs[i].title, audioPath: songs[i].data, albumArtImagePathId: songs[i].id );
        i++;
    }
   return _playlist; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('P L A Y L I S T')),
      drawer: const MyDrawer(),
      body: Center(
        child: !_hasPermission
            ? noAccessToLibraryWidget()
            : FutureBuilder<List<SongModel>>(
                // Default values:
                future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  // Display error, if any.
                  if (item.hasError) {
                    return Text(item.error.toString());
                  }

                  // Waiting content.
                  if (item.data == null) {
                    return const CircularProgressIndicator();
                  }

                  // 'Library' is empty.
                  if (item.data!.isEmpty) return const Text("Nothing found!");

                  // You can use [item.data!] direct or you can create a:
                  // List<SongModel> songs = item.data!;
                  return ListView.builder(
                    itemCount: item.data!.length,
                    itemBuilder: (context, index) {
                       _playlist.add( Song(artistName: item.data![index].artist!, songName: item.data![index].title, audioPath: item.data![index].data, albumArtImagePathId: item.data![index].id ));
                      return ListTile(
                        title: Text(item.data![index].title),
                        subtitle: Text(item.data![index].artist ?? "No Artist"),
                        trailing: const Icon(Icons.arrow_forward_rounded),
                        // This Widget will query/load image.
                        // You can use/create your own widget/method using [queryArtwork].
                        leading: QueryArtworkWidget(
                          controller: _audioQuery,
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                        ),
                       
                        onTap: () => { 
                         
                          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>MainSongPage(item.data![index].data.toString(), item.data![index].id, _playlist, index))),
                          print("sdf"+item.data![index].data.toString()),
                                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("ok",  style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),),backgroundColor: Colors.red,
      //behavior: SnackBarBehavior.fixed,
      padding: EdgeInsets.symmetric(vertical: 5),
      duration: Duration(seconds: 5),
      elevation: 1,
))
                        },
                      );
                    },
                  );
                },
              ),
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
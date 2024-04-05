import 'package:flutter/material.dart';
import 'package:minimal_music_player_app/components/my_drawer.dart';
import 'package:minimal_music_player_app/models/playlist_provider.dart';
import 'package:minimal_music_player_app/models/song.dart';
import 'package:minimal_music_player_app/pages/songpage.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    // Main method.
  final OnAudioQuery _audioQuery = OnAudioQuery();

  // Indicate if application has permission to the library.
  bool _hasPermission = false;

  //get the playlist provider 
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();

    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);

    // Check and request for permission.
    checkAndRequestPermissions();

    //get playlist provider 
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

   checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }

  void goToSong(int songIndex){
    //update current song index
      playlistProvider.currentSongIndex = songIndex;

      //navigate to song page 
      Navigator.push(context, 
      MaterialPageRoute(builder: (context)=> SongPage(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('P L A Y L I S T')),
      drawer: const MyDrawer(),
      body:  Center(
        child: !_hasPermission
            ? noAccessToLibraryWidget()
            :     
       Consumer<PlaylistProvider>( 
        
        builder: (BuildContext context, PlaylistProvider value, Widget? child) {
        //get the playlist
        List<Song> playlist = value.playlist;
        print("playlist"+playlist.toString());
        //return listview UI
        return ListView.builder(
          itemCount: playlist.length,
          itemBuilder: (context, index) {
          //get individual song
          final Song song = playlist[index];


          return ListTile(
              title: Text(song.songName),
              subtitle: Text(song.artistName),
              leading: QueryArtworkWidget(id:song.albumArtImagePathId , type: ArtworkType.AUDIO),
              onTap: ()=> goToSong(index),
          );
        },
          

      );
      }
    
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
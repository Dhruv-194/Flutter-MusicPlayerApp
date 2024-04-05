import 'package:flutter/material.dart';
import 'package:minimal_music_player_app/models/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistProvider extends ChangeNotifier{
//playlist of songs 
final OnAudioQuery _audioQuery = OnAudioQuery();
final List<Song> _playlist = []; 
List<SongModel> songs = [];

 Future <List<SongModel>> querySongs () async {
  
  songs = await _audioQuery.querySongs( sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,);
 
   return songs; 
  }

  List<Song> queryPlaylist (){
    print('queryplaylist');
      querySongs();
        var i =0;
  //  _playlist.clear();
      for(var ele in songs) {
      print(songs[i].artist);
 
           _playlist.add( Song(artistName: songs[i].artist!, songName: songs[i].title, audioPath: songs[i].data, albumArtImagePathId: songs[i].id ));

              i++;
      }

    
 
    return _playlist;
  }



  //current song playing index
  int? _currentSongIndex;


  //GETTERS 
  List<Song> get playlist => queryPlaylist();
  int? get currentSongIndex => _currentSongIndex;

  //SETTERS
  set currentSongIndex(int? newIndex){

    _currentSongIndex = newIndex;

    notifyListeners();
  }
}
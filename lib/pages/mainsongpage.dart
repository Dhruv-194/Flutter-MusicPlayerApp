import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:minimal_music_player_app/models/song.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MainSongPage extends StatefulWidget {
  String uriFile;
  int uriImageID;
  List<Song> playlist;
  int index;
  MainSongPage(this.uriFile, this.uriImageID, this.playlist, this.index);
 

  @override
  State<MainSongPage> createState() => _MainSongPageState(this.uriFile, this.uriImageID, this.playlist, this.index);
}

class _MainSongPageState extends State<MainSongPage> {

  String uriFile; 
  int uriImageID;
    List<Song> playlist;
  int index;
  _MainSongPageState(this.uriFile, this.uriImageID,  this.playlist, this.index);

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying= state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
        setState(() {
          duration = newDuration;
        });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }


  Future setAudio() async{
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    print("yaya" + uriFile);

    // final result = await FilePicker.platform.pickFiles();

    // if(result!=null){
    //   print("dsf");
    //      final file = File(result.files.single.path!);
    //      print("Result: $result  File: $file");
    //      audioPlayer.setSource(DeviceFileSource(file.path));
    // } 
    // final file = File(uriFile);
     //audioPlayer.setSource(DeviceFileSource(file.path));
    //await audioPlayer.play(DeviceFileSource(file.path));

    final file = File(playlist[index].audioPath);
   await audioPlayer.play(DeviceFileSource(file.path));
   // index = index + 1;
    audioPlayer.onPlayerComplete.listen((event) {
      
      if(index<playlist.length){
       // audioPlayer.play(DeviceFileSource(file.path));
       final file = File(playlist[index+1].audioPath);
       audioPlayer.play(DeviceFileSource(file.path));
       setState(() {
         index = index + 1;
       });
     //  index++;
      }
     });

    //audioPlayer.setSource(source)
    
  }

  int changeIndex(int index) {
    setState(() {
     index = index + 1;
     print("index"+index.toString());
    });
    return index;
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius : BorderRadius.circular(20),
            child: QueryArtworkWidget(id:playlist[index].albumArtImagePathId , type: ArtworkType.AUDIO, artworkWidth: double.infinity, artworkHeight: 350, artworkFit: BoxFit.cover,)
            // Image.network('https://images.unsplash.com/photo-1547721064-da6cfb341d50', width: double.infinity, height: 350, fit: BoxFit.cover,),
          ),
          const SizedBox(height: 32,),
           Text( playlist[index].songName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), ),
          const SizedBox(height: 4,),
           Text(playlist[index].artistName, style: TextStyle(fontSize: 20),),

          Slider(min:0, max: duration.inSeconds.toDouble(), value: position.inSeconds.toDouble(), onChanged: (value) async{
            final position = Duration(seconds: value.toInt());
            await audioPlayer.seek(position);

            await audioPlayer.resume();
          }),

          Padding(padding: const EdgeInsets.symmetric(horizontal:16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(formatTime(position)),
              Text(formatTime(duration)),
            ],
          ),),
          CircleAvatar(
            radius: 35,
            child: IconButton(
              icon: Icon(isPlaying? Icons.pause : Icons.play_arrow,
            ),
            iconSize: 50,
            onPressed: () async{
              if(isPlaying){
                await audioPlayer.pause();
              }else{
                await audioPlayer.resume();
              }
            },
          )
          )
        ],
      )),
    );
  }
  
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));


    return [
      if(duration.inHours>0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
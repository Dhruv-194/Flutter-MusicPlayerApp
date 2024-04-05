// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// // import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:path/path.dart';
// // Platform Interface
// import 'package:on_audio_query_platform_interface/on_audio_query_platform_interface.dart';
// export 'package:on_audio_query_platform_interface/on_audio_query_platform_interface.dart';

// // // Controllers
// // part 'src/on_audio_query.dart';

// // // Widgets
// // part 'widget/query_artwork_widget.dart';

// class TrySongsPage extends StatefulWidget {
//   const TrySongsPage({super.key});

//   @override
//   State<TrySongsPage> createState() => _TrySongsPageState();
// }

// class _TrySongsPageState extends State<TrySongsPage> {

//    var files;
//    final OnAudioQuery _audioQuery = OnAudioQuery();
 
//   void getFiles() async { //asyn function to get list of files
//     List<AudioModel> audios = await _audioQuery.queryAudios();
//       List<StorageInfo> storageInfo = await PathProvider.getStorageInfo();
//       var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
//       var fm = FileManager(root: Directory(root)); //
//       files = await fm.filesTree( 
//         excludedPaths: ["/storage/emulated/0/Android"],
//         extensions: ["mp3"] //optional, to filter files, list only mp3 files
//       );
//       setState(() {}); //update the UI
//   }

//   @override
//   void initState() {
//     getFiles(); //call getFiles() function on initial state. 
//     super.initState();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
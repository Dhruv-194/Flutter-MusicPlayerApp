import 'package:flutter/material.dart';
import 'package:minimal_music_player_app/pages/settingspage.dart';
import 'package:minimal_music_player_app/pages/trysongs1.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(children: [

          //logo 
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            ),

          //home tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top:25),
            child: ListTile(
              title:  Text('H O M E'),
              leading: Icon(Icons.home),
              onTap: ()=> {
                Navigator.pop(context),
              },
            ),
          ),

          //settings tile
            Padding(
            padding: const EdgeInsets.only(left: 25.0, top:0),
            child: ListTile(
              title:  Text('S E T T I N G S'),
              leading: Icon(Icons.settings),
              onTap: (){
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),),);
              },
            ),
          ),


          //trysongs1 tile
          //   Padding(
          //   padding: const EdgeInsets.only(left: 25.0, top:0),
          //   child: ListTile(
          //     title:  Text('T R Y S O N G S'),
          //     leading: Icon(Icons.settings),
          //     onTap: (){
          //       Navigator.pop(context);

          //       Navigator.push(context, MaterialPageRoute(builder: (context) => TrySongs1(),),);
          //     },
          //   ),
          // ),
      ],
      ),
    );
  }
}
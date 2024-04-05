import 'package:flutter/material.dart';
import 'package:minimal_music_player_app/themes/dark_mode.dart';
import 'package:minimal_music_player_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier{

  //default set light-mode 
  ThemeData _themeData = lightMode;

  //get theme
  ThemeData get themeData=> _themeData;

  //is DarkMode 
  bool get isDarkMode=> _themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData){
    _themeData = themeData;

    //update UI
    notifyListeners();
  }

  void toggleTheme(){
    if(_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
    
  }

}
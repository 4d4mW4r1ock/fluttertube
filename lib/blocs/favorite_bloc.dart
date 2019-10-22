import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:fluttertube/models/video.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteBloc implements BlocBase{

  Map<String, Video> _favorites = {};

  final  _favController = BehaviorSubject<Map<String, Video>>(seedValue: {});

  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then(
        (prefs){
          if(prefs.getKeys().contains("favorites")){
            _favorites = json.decode(prefs.getString("favorites")).map(
                (key, value){
                  return MapEntry(key, Video.fromJson(value));
                }
            ).cast<String, Video>();
            _favController.add(_favorites);
          }
        }
    );
  }

  void toogleFavorite(Video video){
    if(_favorites.containsKey(video.id)){
      _favorites.remove(video.id);
    }else{
      _favorites[video.id] = video;
    }
    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav(){
    SharedPreferences.getInstance().then(
        (prefs){
          prefs.setString("favorites", jsonEncode(_favorites));
        }
    );
  }

  @override
  void dispose() {
    _favController.close();
  }

}
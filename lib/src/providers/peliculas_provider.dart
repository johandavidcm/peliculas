import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/persona_model.dart';

class PeliculasProvider{
  String _apiKey   = 'c046d2eecbf5036c4bf34fc2c53ebc71';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _pagePopular = 0;
  bool _cargando   = false;
  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopuares() async{
    if(_cargando) return [];
    _cargando = true;
    _pagePopular++;
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : _pagePopular.toString(),
    });
    
    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }
  
  Future<List<Actor>> getCast(String idPelicula) async{
    final url = Uri.https(_url, '/3/movie/$idPelicula/credits', {
      'api_key'  : _apiKey,
      'language' : _language,
    });
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  } 
  
  Future<List<Pelicula>> buscarPelicula(String query) async{
    final url = Uri.https(_url, '/3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query
    });
    return await _procesarRespuesta(url);
  }

  Future<Persona> getPersona(String idPerson) async{
    if(_cargando) return null;
    _cargando = true;
    final url = Uri.https(_url, '/3/person/$idPerson', {
      'api_key'  : _apiKey,
      'language' : _language,
    });
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final persona = new Persona.fromJsonMap(decodedData);
    _cargando = false;
    return persona;
  }

}
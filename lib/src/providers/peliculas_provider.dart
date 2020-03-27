import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{
  String _apiKey   = 'c046d2eecbf5036c4bf34fc2c53ebc71';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _pagePopular = 0;
  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language,
    });

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getPopuares() async{
    _pagePopular++;
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key'  : _apiKey,
      'language' : _language,
      'page'     : _pagePopular.toString(),
    });
    
    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);
    return resp;

  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);
    return peliculas.items;
  }

}
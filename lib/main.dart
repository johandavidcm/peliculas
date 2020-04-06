import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/actor_detail.dart';
import 'package:peliculas/src/pages/home_page.dart';
import 'package:peliculas/src/pages/pelicula_detail.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Películas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/'        : (BuildContext context) => HomePage(),
        'detalle'  : (BuildContext context) => PeliculaDetalle(),
        'actor'    : (BuildContext context) => ActorDetalle(),
      },
    );
  }
}
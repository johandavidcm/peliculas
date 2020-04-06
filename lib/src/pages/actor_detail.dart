import 'package:flutter/material.dart';
import 'package:peliculas/src/models/persona_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class ActorDetalle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final int actorid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: _crearPersona(actorid),
    );
  }

  Widget _crearPersona(int actorid) {
    final peliculaProvider = PeliculasProvider();
    return FutureBuilder(
      future: peliculaProvider.getPersona(actorid.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return _crearPersonaWidet(snapshot.data, context);
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearPersonaWidet(Persona persona, BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          _crearTitulo(persona, context),
          
          Text(persona.biography)
        ],
      ),
    );
  }

  Widget _crearTitulo(Persona persona, BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    return Container(

      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image(
              image: NetworkImage(persona.getImg()),
              width: _screensize.width,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

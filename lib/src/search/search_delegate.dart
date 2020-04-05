import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  final peliculasProvider = PeliculasProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones que tendra el appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono o informacion a la izquierda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
      
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Container();
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen al momento de escribir
    
    if(query.isEmpty){
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula){
              pelicula.uniqueId = '${pelicula.id}-search';
              return Hero(
                tag: pelicula.uniqueId,
                child: ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                ),
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );
  }

}
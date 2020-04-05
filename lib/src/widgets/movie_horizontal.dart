import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;

  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        siguientePagina();
      }
    });
    
    final screensize = MediaQuery.of(context).size;
    
    return Container(
      height: screensize.height*0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        //children: _tarjetas(context),
        itemBuilder: (BuildContext context, int i){
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta (BuildContext context, Pelicula pelicula){
    pelicula.uniqueId = '${pelicula.id}-Horizontal';
    final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption
            ),
          ],
        ),
      );
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
        child: tarjeta,
      );
  }

  /*List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula){
      _tarjeta(context, pelicula);
    }).toList();
  }*/
}
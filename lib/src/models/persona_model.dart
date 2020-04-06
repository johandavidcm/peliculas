class Persona {
  String birthday;
  String uniqueId;
  String knownForDepartment;
  dynamic deathday;
  int id;
  String name;
  List<dynamic> alsoKnownAs;
  int gender;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;
  dynamic homepage;

  Persona({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  Persona.fromJsonMap(Map<String, dynamic> json){
    birthday           = json['birthday'];
    knownForDepartment = json['known_for_department'];
    deathday           = json['deathday'];
    id                 = json['id'];
    name               = json['name'];
    alsoKnownAs        = json['also_known_as'];
    gender             = json['gender'];
    biography          = json['biography'];
    popularity         = json['popularity'];
    placeOfBirth       = json['place_of_birth'];
    profilePath        = json['profile_path'];
    adult              = json['adult'];
    imdbId             = json['imdb_id'];
    homepage           = json['homepage'];
  }

  getImg(){
    if(profilePath == null){
      return 'https://pbs.twimg.com/profile_images/600060188872155136/st4Sp6Aw_400x400.jpg';
    }
    else{
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
  }

}

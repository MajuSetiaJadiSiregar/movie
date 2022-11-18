class ResponseListMovie {
  String status;
  List<Movie> movie;

  ResponseListMovie({required this.status, required this.movie});

  factory ResponseListMovie.fromJson(Map<String, dynamic> json) {
    var listMovie = json["data"] as List;
    List<Movie> movieList = listMovie.map((e) => Movie.fromJson(e)).toList();
    return ResponseListMovie(status: json["status"], movie: movieList);
  }

}

class ResponseErrorMovie {
  String message;

  ResponseErrorMovie({required this.message});

  factory ResponseErrorMovie.fromJson(Map<String, dynamic> json) {
    return ResponseErrorMovie(message: json["message"]);
  }
}

class Movie {
  int id;
  String title;
  String desc;
  String poster;
  String createdAt;

  Movie({required this.id, required this.title, required this.desc, required this.poster, required this.createdAt});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(id: json["id"], title: json["title"], desc: json["description"], poster: json["poster"], createdAt: json["created_date"]);
  }
}

class CreateMovie {
  String status;

  CreateMovie({required this.status});

  factory CreateMovie.fromJson(Map<String, dynamic> json) {
    return CreateMovie(status: json["status"]);
  }
}
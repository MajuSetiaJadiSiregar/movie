part of 'controller.dart';


class HomeController extends GetxController {

  final stateHome = StateHome(
    movie: <Movie>[]
  ).obs;

  void readMovies() async {
    try {

      ResponseListMovie? responseListMovie = await Service.readMovie();

      if(responseListMovie != null) {

        stateHome.update((_) {
          stateHome.value.movie = responseListMovie.movie;
        });
      }

    }catch(e){
      throw Exception(e.toString());
    }
  }


  @override
  void onInit() {
    super.onInit();
    readMovies();
  }
}

class StateHome {
  List<Movie> movie;

  StateHome({required this.movie});
}
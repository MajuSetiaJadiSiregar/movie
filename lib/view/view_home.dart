part of 'view.dart';

class HomeView extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF000B49),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text('Explore', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, )),
                ),
                // Row(
                //   children: [
                //     Text('Explore', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, )),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        child: Text('add'),
        onPressed: () {
          Get.to(() => AddView());
        },
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20.0),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.headline6,
                    children: [
                      TextSpan(
                        text: 'List ',
                        style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: 'Movies')
                    ]
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _homeController.stateHome.value.movie.length,
                itemBuilder: (_, i) {
                  return MovieListItem(
                    id: _homeController.stateHome.value.movie[i].id,
                    title: _homeController.stateHome.value.movie[i].title,
                    desc: _homeController.stateHome.value.movie[i].desc,
                    poster: _homeController.stateHome.value.movie[i].poster,
                    createdAt: _homeController.stateHome.value.movie[i].createdAt,
                  );
                },
              )
              // for(final movie in _homeController.stateHome.value.movie) MovieListItem(id: movie.id, title: movie.title, desc: movie.desc, poster: movie.poster, createdAt: movie.createdAt)
            ],
          ),
        ),
      );
    });
  }

}


class _CustomClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }





}

class MovieListItem extends StatelessWidget {
  final int id;
  final String title;
  final String desc;
  final String poster;
  final String createdAt;
  final GlobalKey backgroundImageKey = GlobalKey();

  MovieListItem({Key? key, required this.id, required this.title, required this.desc, required this.poster, required this.createdAt}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: [
              Image.network(poster, key: backgroundImageKey,fit: BoxFit.cover,width: double.infinity,),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.6, 0.95]
                    )
                  ),
                ),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
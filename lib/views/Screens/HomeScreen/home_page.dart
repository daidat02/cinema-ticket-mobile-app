import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/models/User.dart';
import 'package:shop/providers/authProvider.dart';
import 'package:shop/services/API/api_moive_services.dart';
import 'package:shop/services/stores.dart';
import 'package:shop/views/Screens/HomeScreen/widget/section_header_widget.dart';
import 'package:shop/views/Screens/HomeScreen/widget/section_title_widget.dart';
import 'package:shop/views/Widgets/line_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/main_app_bar.dart';
import 'package:shop/views/Widgets/top_movie_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user;
  int _currentIndex = 0;
  List<Movie> movies = [];
  final MovieService _movieService = MovieService();
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    fetchUser();
    loadMovies();
  }

  Future<void> fetchUser() async {
    User? userData = await Storage.getUser();
    setState(() {
      user = userData;
    });
  }

  Future<void> loadMovies() async {
    try {
      LoadingOverlay.show(context);
      List<Movie> loadedMovies = await _movieService.loadMoviesApi();
      setState(() {
        movies = loadedMovies;
      });
      // Tạo độ trễ 1 giây trước khi ẩn loading
      await Future.delayed(const Duration(seconds: 2));
      LoadingOverlay.hide();
    } catch (e) {
      LoadingOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return MainAppBar(user: authProvider.user);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 60),
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search
              Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xffFAFAFA),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/search_icon.svg',
                      width: 20,
                      height: 20,
                      allowDrawingOutsideViewBox: true, // Fix lỗi filter
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Tìm Kiếm ...',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset('assets/images/slide.png')),
              const SizedBox(height: 20),

              // Top movies
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: sectionTitleWidget('Phim Nổi Bật')),
              SizedBox(
                height: 410,
                child: FlutterCarousel(
                  items: movies
                      .map((movie) => TopMovieCard(movie: movie))
                      .toList(),
                  options: CarouselOptions(
                    height: 500,
                    viewportFraction: 0.6,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    showIndicator: false,
                  ),
                ),
              ),
              LineWidget(),
              const SizedBox(height: 10),

              sectionHeader('Phim Đang Chiếu', 'Xem tất cả', 0xFF007AFF,
                  '/list_movie', true),
              SizedBox(
                height: 340, // Đặt chiều cao rõ ràng cho danh sách phim
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 10),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 180,
                      height: 270, // Đặt chiều rộng cố định cho từng item
                      child: TopMovieCard(movie: movies[index]),
                    );
                  },
                ),
              ),

              LineWidget(),
              const SizedBox(height: 10),

              sectionHeader('Phim Sắp Chiếu', 'Xem tất cả', 0xFF007AFF,
                  '/list_movie', false),

              SizedBox(
                height: 340, // Đặt chiều cao rõ ràng cho danh sách phim
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(right: 10),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 180,
                      height: 270, // Đặt chiều rộng cố định cho từng item
                      child: TopMovieCard(movie: movies[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

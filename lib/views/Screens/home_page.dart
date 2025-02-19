import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/models/Movie.dart';
import 'package:shop/models/User.dart';
import 'package:shop/views/Widgets/main_app_bar.dart';
import 'package:shop/views/Widgets/top_movie_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User? user;
  int _currentIndex = 0;

  final List<Movie> movies = [
    Movie(
      imageUrl: 'assets/images/movie1.png',
      title: 'Avatar 3',
      description: 'Phim khoa học viễn tưởng',
      rating: 4.5,
    ),
    Movie(
      imageUrl: 'assets/images/movie2.png',
      title: 'Black Panther',
      description: 'Phim siêu anh hùng',
      rating: 4.8,
    ),
    Movie(
      imageUrl: 'assets/images/movie2.png',
      title: 'Avengers: Endgame',
      description: 'Phim hành động',
      rating: 4.9,
    ),
  ];

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      user = User(
        name: 'Yến Vy',
        membershipType: 'Member',
        starCount: 5,
        ticketCount: 9,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: MainAppBar(user: user),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // search
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Biểu tượng tìm kiếm
                    SvgPicture.asset(
                      'assets/icons/search_icon.svg', // Đảm bảo có biểu tượng tìm kiếm tại đây
                      width: 20, // Điều chỉnh kích thước biểu tượng
                      height: 20,
                    ),
                    const SizedBox(width: 10),
                    // TextField cho phép người dùng nhập liệu
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm phim',
                          hintStyle: TextStyle(fontSize: 14),
                          border:
                              InputBorder.none, // Loại bỏ viền của TextField
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                child: Image.asset('assets/images/slide.png'),
              ),

              const SizedBox(height: 20),

              //top movies
              const Text(
                'Phim Nổi Bật',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FlutterCarousel(
                items: movies.map((movie) {
                  return TopMovieCard(
                    movie: movie,
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 350,
                  viewportFraction: 0.7,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  // autoPlay: true,
                  // autoPlayInterval: const Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  showIndicator: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: const Column(
                  children: [
                    Text(
                      'Phim Đang Chiếu',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
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

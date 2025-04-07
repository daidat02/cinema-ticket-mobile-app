import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/providers/movieProvider.dart';
import 'package:shop/services/API/api_moive_services.dart';
import 'package:shop/services/stores.dart';
import 'package:shop/views/Widgets/btn_bottom_widget.dart';
import 'package:shop/views/Widgets/line_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';
import 'package:shop/views/Widgets/postter_widget.dart';
import 'package:shop/views/Widgets/toast_widget.dart';

class DetailMovie extends StatefulWidget {
  final Movie movie;
  const DetailMovie({super.key, required this.movie});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  final MovieService _movieService = MovieService();

  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final isFav = await movieProvider.isMovieFavorite(widget.movie.sId ?? '');
    print(isFav);
    setState(() {
      isFavorite = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    DateTime? releaseDate = widget.movie.releaseDate;
    String formattedDate = releaseDate != null
        ? DateFormat('dd/MM/yyyy').format(releaseDate)
        : 'Ngày phát hành không xác định';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBarWidget(title: "Thông tin phim"),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                height: 170,
                child: Row(
                  children: [
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: PosterWidget(imageUrl: widget.movie.imageUrl),
                    ),
                    const SizedBox(width: 10), // Thêm khoảng cách
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title ?? 'Chưa có tiêu đề',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.movie.genre ??
                                'Chưa phân loại', // Sửa genres thành genre
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 1),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 152, 35, 26),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  'C18',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'Phim được phổ biến đến người xem từ 18 tuổi trở lên',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(255, 105, 105, 105)),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FavoriteButtonWidget(
                                movieId: widget.movie.sId ?? '',
                              ),
                              ActionButtonWidget('Trailer', 'play_icon.svg'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    detailInfoBox('Ngày Khởi Chiếu', formattedDate,
                        hasRightBorder: true),
                    detailInfoBox(
                        'Thời Lượng',
                        widget.movie.duration != null
                            ? '${widget.movie.duration} phút'
                            : '120 phút',
                        hasRightBorder: true),
                    detailInfoBox('Ngôn Ngữ', 'Phụ đề', hasRightBorder: false),
                  ],
                ),
              ),
              LineWidget(),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Căn giữa theo chiều ngang
                  children: [
                    const SectionHeaderWidget(title: 'Nội dung phim'),
                    const SizedBox(height: 8),
                    ReadMoreText(
                      widget.movie.description ?? 'Chưa có mô tả cho phim này.',
                      trimLines: 4, // Hiển thị 3 dòng, sau đó thu gọn
                      colorClickableText: Colors.blue, // Màu chữ "Xem thêm"
                      trimMode: TrimMode.Line, // Cắt theo dòng
                      trimCollapsedText: ' Xem thêm',
                      trimExpandedText: ' Rút gọn',
                      style: const TextStyle(fontSize: 14),
                      moreStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              LineWidget(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeaderWidget(title: 'Đạo Diễn & Diễn Viên'),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Đạo diễn: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.movie.director ?? 'Chưa có thông tin',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Diễn viên: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.movie.actor ?? 'Chưa có thông tin',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              LineWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BtnBottomWidget(
        title: 'Mua Vé',
        data: widget.movie,
        onPressed: (Movie movie) =>
            {Navigator.pushNamed(context, '/showtime', arguments: movie)},
      ),
    );
  }

  Widget detailInfoBox(String title, value, {bool hasRightBorder = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          right: hasRightBorder
              ? const BorderSide(color: Color(0xFF6E6D6D), width: 0.5)
              : BorderSide.none,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget ActionButtonWidget(String title, String pathName) {
    // Xác định có phải nút yêu thích không
    final isHeartButton = pathName == 'heart_icon.svg';

    // Màu icon: đỏ nếu là yêu thích, màu mặc định nếu không
    final color = isHeartButton && isFavorite
        ? Colors.red
        : const Color.fromARGB(255, 110, 109, 109);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(color: color, width: 0.5),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/$pathName',
            height: 18,
            width: 18,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  const SectionHeaderWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}

class FavoriteButtonWidget extends StatefulWidget {
  final String movieId;

  const FavoriteButtonWidget({
    super.key,
    required this.movieId,
  });

  @override
  _FavoriteButtonWidgetState createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final isFav = await movieProvider.isMovieFavorite(widget.movieId ?? '');
    setState(() {
      _isFavorite = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFavorite,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(
            color: _isFavorite
                ? Colors.red
                : const Color.fromARGB(255, 110, 109, 109),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/heart_icon.svg',
              height: 18,
              width: 18,
              color: _isFavorite
                  ? Colors.red
                  : const Color.fromARGB(255, 110, 109, 109),
            ),
            const SizedBox(width: 5),
            Text(
              'Yêu thích',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: _isFavorite
                    ? Colors.red
                    : const Color.fromARGB(255, 110, 109, 109),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleFavorite() async {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    try {
      LoadingOverlay.show(context);
      setState(() {
        _isFavorite = !_isFavorite;
      });
      final message = await movieProvider.toggleFavorite(widget.movieId ?? '');
      LoadingOverlay.hide();
      SuccessToastWidget.show(context, message);
    } catch (e) {
      LoadingOverlay.hide();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${e.toString()}')),
      );
    }
  }
}

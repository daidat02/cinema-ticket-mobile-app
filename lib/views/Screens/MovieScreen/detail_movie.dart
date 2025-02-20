import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/models/Movie.dart';

class DetailMovie extends StatefulWidget {
  final Movie movie;
  const DetailMovie({super.key, required this.movie});

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBarWidget(title: "Thông tin phim"),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 160,
                child: Row(
                  children: [
                    SizedBox(
                      height: 160,
                      width: 120,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: AspectRatio(
                          aspectRatio: 5 / 6.5,
                          child: widget.movie.imageUrl.startsWith('http')
                              ? Image.network(
                                  widget.movie.imageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                    child: Icon(Icons.broken_image,
                                        color: Colors.red, size: 50),
                                  ),
                                )
                              : Image.asset(
                                  widget.movie.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Thêm khoảng cách
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.movie.genres,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
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
                                // ✅ Để tránh lỗi `RenderBox`
                                child: Text(
                                  'Phim được phổ biến đến người xem từ 18 tuổi trở lên',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 105, 105,
                                          105)), // 🔥 Sửa màu chữ
                                  overflow:
                                      TextOverflow.clip, // ✅ Tránh tràn chữ
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ActionButtonWidget('Yêu thích', 'heart_icon.svg'),
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
                    detailInfoBox('Ngày Khởi Chiếu', '21/02/2025',
                        hasRightBorder: true),
                    detailInfoBox('Thời Lượng', '120 phút',
                        hasRightBorder: true),
                    detailInfoBox('Ngôn Ngữ', 'Phụ đề', hasRightBorder: false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget detailInfoBox(String title, String value,
      {bool hasRightBorder = true}) {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(
            color: const Color.fromARGB(255, 110, 109, 109), width: 0.5),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/$pathName',
            height: 18,
            width: 18,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class PageAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const PageAppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xFFdf4f4f), // ✅ Sửa mã màu hợp lệ
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SvgPicture.asset(
              'assets/icons/close_icon.svg',
              height: 18,
              width: 18,
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/models/Movie.dart';

class TopMovieCard extends StatelessWidget {
  final Movie movie;
  const TopMovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Chuyển đến trang chi tiết phim
        Navigator.pushNamed(
          context,
          '/detail_movie',
          arguments: movie,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 5, right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hình ảnh phim (bo góc, giữ đúng tỉ lệ)
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 5 / 6.5, // Giữ tỉ lệ ảnh 16:9
                child: movie.imageUrl.startsWith('http')
                    ? Image.network(
                        movie.imageUrl,
                        fit: BoxFit.contain, // Cắt ảnh vừa với khung
                        loadingBuilder: (context, child, loadingProgress) {
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
                        movie.imageUrl,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            // Thông tin phim
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/star_icon.svg',
                        height: 14,
                        width: 14,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${movie.rating}/10 (700 Đánh giá)',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.genres, // Thể loại phim
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/MovieShowtimeModel.dart';
import 'package:shop/models/ShowtimeModel.dart';
import 'package:shop/services/API/api_showtimes_service.dart';
import 'package:shop/views/Screens/ShowtimeScreen/widget/datetime_widget.dart';
import 'package:shop/views/Screens/ShowtimeScreen/widget/showtime_time_item_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';

class ShowtimeCinemaScreen extends StatefulWidget {
  final String cinemaId;
  const ShowtimeCinemaScreen({super.key, required this.cinemaId});

  @override
  State<ShowtimeCinemaScreen> createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeCinemaScreen> {
  final ShowtimesService _showtimesService = ShowtimesService();

  int selectedIndex = 0;
  DateTime selectedDate = DateTime.now();
  List<MovieShowtime> movieShowtime = [];

  @override
  void initState() {
    super.initState();
    loadShowtimes(widget.cinemaId, selectedDate);
  }

  void handleDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    loadShowtimes(widget.cinemaId, date);
  }

  Future<void> loadShowtimes(String cinemaId, DateTime date) async {
    try {
      LoadingOverlay.show(context);
      List<MovieShowtime> loadedShowtimes =
          await _showtimesService.loadMovieShowtimes(cinemaId, date);
      if (mounted) {
        setState(() {
          movieShowtime = loadedShowtimes;
        });
      }
    } catch (e) {
      debugPrint('Error loading showtimes: $e');
      // Xử lý lỗi tại đây nếu cần
    } finally {
      if (mounted) {
        LoadingOverlay.hide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: const PageAppBarWidget(title: 'Rạp chiếu'),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: const BoxDecoration(color: Colors.white),
            child: DatetimeWidget(onDateSelected: handleDateSelected),
          ),
          if (movieShowtime.isEmpty)
            const Expanded(
              child:
                  Center(child: Text('Không có suất chiếu nào trong ngày này')),
            )
          else
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: movieShowtime.length,
                itemBuilder: (context, index) {
                  final movie = movieShowtime[index];
                  return _buildMovieCard(movie);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMovieCard(MovieShowtime movie) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie info section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.movieName ?? 'Không có tên phim',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${movie.movieDuration ?? 0} phút',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.movie, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      movie.movieGenre ?? 'Không rõ thể loại',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.movieImage ?? '',
                    width: 120,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 100,
                      height: 150,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Showtimes grid
                if (movie.showtimes != null && movie.showtimes!.isNotEmpty)
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.6,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: movie.showtimes!.length,
                      itemBuilder: (context, index) {
                        final showtime = movie.showtimes![index];
                        return GestureDetector(
                            onTap: () => {
                                  Navigator.pushNamed(
                                      context, '/seat_selection',
                                      arguments: showtime.id),
                                },
                            child: ShowtimeItemWidget(showtime: showtime));
                      },
                    ),
                  )
                else
                  const Expanded(
                    child: Center(child: Text('Không có suất chiếu')),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

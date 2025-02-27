import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shop/models/CinemaShowtime.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/services/API/api_showtimes_service.dart';
import 'package:shop/views/Screens/ShowtimeScreen/widget/cinema_showtimes_widget.dart';
import 'package:shop/views/Screens/ShowtimeScreen/widget/datetime_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';
import 'package:shop/views/Widgets/postter_widget.dart';

class ShowtimeScreen extends StatefulWidget {
  final Movie movie;

  const ShowtimeScreen({super.key, required this.movie});

  @override
  State<ShowtimeScreen> createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeScreen> {
  final ShowtimesService _showtimesService = ShowtimesService();

  int selectedIndex = 0; // Biến lưu trạng thái ngày được chọn
  DateTime selectedDate = DateTime.now(); // Biến lưu ngày đã chọn
  List<CinemaShowtimes> cinemaShowtimes = [];

  @override
  void initState() {
    super.initState();
    loadShowtimes(widget.movie.sId, selectedDate);
  }

  void handleDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    final DateTime utcTime = selectedDate.toUtc();
    print("Ngày được chọn (Local): ${selectedDate.toLocal()}");

    print("Ngày được chọn (UTC): $utcTime");

    loadShowtimes(widget.movie.sId, date);
  }

  Future<void> loadShowtimes(movieId, date) async {
    List<CinemaShowtimes> loadedShowtimes =
        await _showtimesService.loadCinemaShowtimes(movieId, date);
    if (mounted) {
      setState(() {
        cinemaShowtimes = loadedShowtimes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      appBar: PageAppBarWidget(title: widget.movie.title ?? '???'),
      body: Column(
        children: [
          Container(
            height: 140,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                SizedBox(
                    height: 140,
                    width: 100,
                    child:
                        PosterWidget(imageUrl: widget.movie.imageUrl ?? '??')),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.title ?? '??',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.movie.genre ??
                            'Chưa phân loại', // Sửa genres thành genre
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.normal),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 1),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 152, 35, 26),
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
                                  color: Color.fromARGB(255, 105, 105, 105)),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: const BoxDecoration(color: Colors.white),
              child: DatetimeWidget(onDateSelected: handleDateSelected)),
          Expanded(
            child: Container(
              height: 200,
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              child: ListView.builder(
                itemCount: cinemaShowtimes.length,
                itemBuilder: (context, index) {
                  var cinema = cinemaShowtimes[index];
                  return CinemaShowtimesWidget(
                    cinema: cinema,
                    onShowTimeSelected: (String showTimeId) {
                      print("Selected showtime id: $showTimeId");
                      // Thực hiện các hành động cần thiết, ví dụ: điều hướng đến màn hình đặt vé
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

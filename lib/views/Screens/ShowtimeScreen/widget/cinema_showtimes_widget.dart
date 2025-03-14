import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/models/CinemaShowtime.dart';
import 'package:shop/views/Screens/ShowtimeScreen/widget/showtime_time_item_widget.dart';

class CinemaShowtimesWidget extends StatelessWidget {
  final Function(String) onShowTimeSelected;
  final bool isLast;
  const CinemaShowtimesWidget(
      {super.key,
      required this.cinema,
      required this.onShowTimeSelected,
      required this.isLast});

  final CinemaShowtimes cinema;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8, top: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 216, 216, 216),
                      style: BorderStyle.solid))),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide.none,
        ),
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(3),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xffEEF6FF),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                      width: 1,
                      color: const Color(0xffD3D3D3),
                      style: BorderStyle.solid)),
              child: SvgPicture.asset(
                'assets/logo/logo_text.svg',
                height: 30,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              cinema.cinemaName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        children: [
          // Sử dụng Container để áp dụng padding cho grid view
          Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150, // Chiều rộng tối đa của mỗi item
                  mainAxisExtent: 65, // Chiều cao cố định của mỗi item
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: cinema.showtimes.length,
                itemBuilder: (context, index) {
                  final showtime = cinema.showtimes[index];
                  return GestureDetector(
                      onTap: () => {
                            onShowTimeSelected(showtime.id),
                            Navigator.pushNamed(context, '/seat_selection',
                                arguments: showtime.id),
                          },
                      child: ShowtimeItemWidget(showtime: showtime));
                },
              ))
        ],
      ),
    );
  }
}

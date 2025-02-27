import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/ShowtimeModel.dart';

class ShowtimeItemWidget extends StatelessWidget {
  const ShowtimeItemWidget({
    super.key,
    required this.showtime,
  });

  final Showtime showtime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 216, 216, 216),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('HH:mm').format(showtime.startTime.toLocal()),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  ' ~ 11:30',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xff0094FF).withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Text(
                'Còn 127/168',
                style: TextStyle(fontSize: 12, color: Color(0xff0094FF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

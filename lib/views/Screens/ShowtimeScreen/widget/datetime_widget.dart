import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatetimeWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected; // Callback để gửi ngày đã chọn

  const DatetimeWidget({super.key, required this.onDateSelected});
  @override
  State<DatetimeWidget> createState() => _DatetimeState();
}

class _DatetimeState extends State<DatetimeWidget> {
  int selectedIndex = 0; // Biến lưu trạng thái ngày được chọn

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<DateTime> days =
        List.generate(15, (index) => today.add(Duration(days: index)));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: days.length,
          itemBuilder: (context, index) {
            String weekDay = DateFormat('EEEE', 'vi').format(days[index]);
            if (days[index].day == today.day &&
                days[index].month == today.month &&
                days[index].year == today.year) {
              weekDay = 'H.Nay';
            } else {
              weekDay = DateFormat('EEEE', 'vi').format(days[index]);
              weekDay = weekDay
                  .replaceAll('Hai', '2')
                  .replaceAll('Ba', '3')
                  .replaceAll('Tư', '4')
                  .replaceAll('Năm', '5')
                  .replaceAll('Sáu', '6')
                  .replaceAll('Bảy', '7')
                  .replaceAll('Chủ nhật', 'CN');
            }
            String day =
                DateFormat('dd').format(days[index]); // Ngày (01, 02, ...)

            bool isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onDateSelected(days[index]);
              },
              child: Container(
                width: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xff0094FF)
                        : const Color(0xffE5E5E5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          weekDay,
                          style: TextStyle(
                              color: isSelected
                                  ? const Color(0xff0094FF)
                                  : const Color(0xff000000),
                              fontSize: 10,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: isSelected
                            ? const Color(0xff0094FF)
                            : const Color(0xffE5E5E5),
                      ),
                      alignment: Alignment
                          .center, // Căn giữa text theo cả chiều ngang & dọc
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

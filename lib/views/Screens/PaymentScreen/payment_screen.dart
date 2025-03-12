import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/CinemaModel.dart';
import 'package:shop/models/DetailShowtime.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/models/RoomModel.dart';
import 'package:shop/models/SeatModel.dart';
import 'package:shop/views/Screens/PaymentScreen/widgets/food_combo_card_widget.dart';
import 'package:shop/views/Widgets/btn_bottom_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';
import 'package:shop/views/Widgets/postter_widget.dart';

class PaymentScreen extends StatefulWidget {
  final DetailShowtime? detailShowtime;
  final List<Seat>? selectedSeats;
  const PaymentScreen({super.key, this.detailShowtime, this.selectedSeats});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Movie? movie = widget.detailShowtime?.movie;
    final Cinema? cinema = widget.detailShowtime?.cinema;
    final Room? room = widget.detailShowtime?.room;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 248, 248),
      appBar: const PageAppBarWidget(title: 'Thông tin thanh toán'),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thông tin đặt vé',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                // thông tin phim
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: 40,
                          margin: const EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: const Color(0xff0094FF).withOpacity(0.1)),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 109, 109, 109),
                              ),
                              children: [
                                TextSpan(text: 'Bạn ơi, vé đã mua sẽ '),
                                TextSpan(
                                  text: 'không thể hoàn, hủy và đổi vé',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold), // In đậm
                                ),
                                TextSpan(
                                    text:
                                        '. Bạn nhớ kiểm tra kỹ thông tin nha!!'),
                              ],
                            ),
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            child: PosterWidget(imageUrl: movie?.imageUrl),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border: Border.all(
                                              color: const Color(0xffD3D3D3))),
                                      child: SvgPicture.asset(
                                          'assets/logo/logo2.svg'),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      cinema?.name ?? '',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 133, 132, 132)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  movie?.title ?? '',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 213, 25, 11),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Text(
                                        '18+',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            8), // Thêm khoảng cách giữa các phần tử
                                    const Expanded(
                                      child: Text(
                                        'Phim được phổ biến đến người xem từ 18 tuổi trở lên',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color.fromARGB(
                                                255, 133, 132, 132)),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                // thông tin vé
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 140,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border(
                          top: BorderSide(
                              color: Color(0xffD0D1D9),
                              width: 1,
                              style: BorderStyle.solid))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleTextWidget('Thời gian:'),
                          Text(
                            // '14:20 ~ 15:57 | Thứ 5, 27/2/2025 | 2D Phụ đề',
                            '${DateFormat('HH:mm').format(widget.detailShowtime?.startTime?.toLocal() ?? DateTime.now())} ~ 15:57 ',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            // '14:20 ~ 15:57 | Thứ 5, 27/2/2025 | 2D Phụ đề',
                            '${DateFormat('EEEE', 'vi').format(widget.detailShowtime?.startTime?.toLocal() ?? DateTime.now())}, ${DateFormat('dd/MM/yyyy').format(widget.detailShowtime?.startTime?.toLocal() ?? DateTime.now())}',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          titleTextWidget('Số ghế:'),
                          Row(
                            children: [
                              ...widget.selectedSeats!.map((seat) {
                                return Text(
                                  '${seat.seatNumber} ' ?? 'Không có số ghế',
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleTextWidget('Phòng chiếu :'),
                          Text(
                            room?.name ?? '',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          titleTextWidget('Định dạng :'),
                          const Text(
                            '2D Phụ đề',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Combo Bắp Nước',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [FoodComboCardWidget(selectedIndex: selectedIndex)],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Thông tin người nhận',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nguyễn Trần Yến Vy',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '09839123123 - ntyv2321@gmail.com',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 122, 122, 122)),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
      bottomNavigationBar: Container(
        height: 120,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tổng Tiền'),
                  Text(
                    '200.000đ',
                    // '${NumberFormat.decimalPattern().format(totalPrice)}đ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            BtnBottomWidget(
                title: 'Thanh Toán',
                data: 'Thanh toán',
                onPressed: (String data) => {print(data)})
          ],
        ),
      ),
    );
  }

  Text titleTextWidget(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 166, 166, 166)),
    );
  }
}

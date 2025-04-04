import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/CinemaModel.dart';
import 'package:shop/models/DetailShowtime.dart';
import 'package:shop/models/MovieModel.dart';
import 'package:shop/models/RoomModel.dart';
import 'package:shop/models/SeatModel.dart';
import 'package:shop/models/User.dart';
import 'package:shop/services/API/api_payment_service.dart';
import 'package:shop/services/stores.dart';
import 'package:shop/views/Screens/PaymentScreen/widgets/food_combo_card_widget.dart';
import 'package:shop/views/Widgets/btn_bottom_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';
import 'package:shop/views/Widgets/postter_widget.dart';
import 'package:shop/views/Widgets/toast_widget.dart';

class PaymentScreen extends StatefulWidget {
  final DetailShowtime? detailShowtime;
  final List<Seat>? selectedSeats;
  final double? totalPriceTicket;
  const PaymentScreen(
      {super.key,
      this.detailShowtime,
      this.selectedSeats,
      this.totalPriceTicket});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Movie? movie;
  late Cinema? cinema;
  late Room? room;
  User? user;
  String? accessToken;
  final PaymentService = ApiPaymentService();
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      movie = widget.detailShowtime!.movie;
      cinema = widget.detailShowtime!.cinema;
      room = widget.detailShowtime!.room;
    });
    _loadUser();
  }

  Future<void> _loadUser() async {
    User? fetchedUser = await Storage.getUser();
    String? fetchAccessToken = await Storage.getAccessToken();
    setState(() {
      user = fetchedUser;
      accessToken = fetchAccessToken;
    });
    print(user?.sId ?? '');
  }

  void _bookticket(String data) async {
    final bookData = {
      'showtimeId': widget.detailShowtime?.sId,
      'seats': widget.selectedSeats?.map((seat) => seat.sId.toString()).toList()
    };
    try {
      LoadingOverlay.show(context);
      await Future.delayed(const Duration(seconds: 2));
      final response = await PaymentService.bookTicket(bookData, accessToken);

      final vnpResponse = await PaymentService.createVnPayUrl(
          response['ticket']['id'], accessToken);

      Navigator.pushNamed(context, '/vnp-payment',
          arguments: vnpResponse['data']);
      // SuccessToastWidget.show(context, response['message']);
      LoadingOverlay.hide();
    } catch (e) {
      LoadingOverlay.hide();
      SuccessToastWidget.show(
          context, e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                      padding: const EdgeInsets.all(2),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffF5F9FE),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(3)),
                                          border: Border.all(
                                              color: const Color(0xffD3D3D3))),
                                      child: SvgPicture.asset(
                                          'assets/logo/logo_text.svg'),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user?.name ?? '',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${user?.phoneNumber ?? ''} - ${user?.email ?? ''}',
                        style: const TextStyle(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tổng Tiền'),
                  Text(
                    '${NumberFormat.decimalPattern().format(widget.totalPriceTicket) ?? 0}đ',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            BtnBottomWidget(
                title: 'Thanh Toán',
                data: 'Thanh toán',
                onPressed: (String data) => _bookticket(data))
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

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/constants/TextStyle.dart';
import 'package:shop/models/TicketModel.dart';
import 'package:shop/models/User.dart';
import 'package:shop/services/API/api_ticket_service.dart';
import 'package:shop/services/stores.dart';
import 'package:shop/views/Screens/HomeScreen/widget/section_header_widget.dart';
import 'package:shop/views/Screens/ProfileScreen/menu_screen.dart';
import 'package:shop/views/Widgets/line_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/postter_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TransformationController _transformationController =
      TransformationController();

  final ticketService = ApiTicketService();
  List<Ticket> tickets = [];
  User? user;
  Future<void> getTickets() async {
    try {
      String? accessToken = await Storage.getAccessToken();
      User? loadUser = await Storage.getUser();
      final List<Ticket> loadTickets =
          await ticketService.getTicketsByUserId(accessToken ?? '');
      if (mounted) {
        setState(() {
          tickets = loadTickets;
          user = loadUser;
        });
      }
    } catch (e) {
      LoadingOverlay.hide();

      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTickets();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/logo/logo_text.svg',
          height: 20,
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.menu), // Icon menu
              onPressed: () => {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xffD9D9D9)))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/user_icon.svg',
                      height: 80,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      user?.name ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Chỉnh Sửa Thông Tin',
                      style: TextStyle(fontSize: 12, color: Color(0xff3461FD)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        itemWidget(
                          iconPath: 'assets/icons/Ticket.svg',
                          title: 'Vé Đã Mua',
                          count: user?.ticketsBooked ?? 0,
                          color: 0xffF5FFF4,
                        ),
                        itemWidget(
                          iconPath: 'assets/icons/show_icon.svg',
                          title: 'Phim Đã Xem',
                          count: user?.moviesWatched ?? 0,
                          color: 0xffE9F6FF,
                        ),
                        itemWidget(
                          iconPath: 'assets/icons/star_icon.svg',
                          title: 'Đánh Giá',
                          count: user?.totalReviews ?? 0,
                          color: 0xffFFFDF0,
                        ),
                        const itemWidget(
                          iconPath: 'assets/icons/edit_icon.svg',
                          title: 'Bình luận',
                          count: 10,
                          color: 0xffEDF2FF,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              sectionHeader('Vé Chưa Sử Dụng', 'Xem tất Cả', 0xFF3461FD),
              Container(
                  child: tickets.isNotEmpty
                      ? TicketCardWidget(ticket: tickets.first)
                      : const NewWidget()),
              const SizedBox(
                height: 10,
              ),
              LineWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class TicketCardWidget extends StatelessWidget {
  const TicketCardWidget({
    super.key,
    required this.ticket,
  });

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              child: PosterWidget(
                imageUrl: ticket.showtime?.movie?.imageUrl ?? 'N/A',
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.showtime?.movie?.title ?? '',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Thứ 6, 02/07 | 8:30 ~ 10:00 | 2D Lồng Tiếng',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xffF5F9FE),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(3)),
                          border: Border.all(color: const Color(0xffD3D3D3)),
                        ),
                        child: SvgPicture.asset('assets/logo/logo_text.svg'),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        ticket.showtime?.cinema?.name ?? '',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 133, 132, 132)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Số Ghế: ${ticket.seats?.map((seat) => seat.seatNumber).join(' ') ?? 'N/A'}',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 133, 132, 132)),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phòng: ${ticket.showtime?.room?.name ?? ''}',
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 133, 132, 132)),
                      ),
                      SizedBox(
                        height: 25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff3461FD),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () => {print(ticket.sId)},
                          child: const Text('Sử Dụng',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            )
          ],
        ));
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: SvgPicture.asset(
            'assets/icons/ticket_icon1.svg',
            height: 140,
          ),
        ),
        const Text(
          'Hiện tại bạn chưa đặt vé nào cả',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Đặt vé dễ dàng qua MBoooking',
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xff7C8BA0)),
        ),
        const SizedBox(
          height: 5,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff3461FD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => {Navigator.pushNamed(context, '/')},
            child: const Text(
              'Đặt Vé Ngay',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}

class itemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final int color;
  final int count;
  const itemWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.iconPath,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
            padding: const EdgeInsets.all(12),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(color)),
            child: SvgPicture.asset(
              iconPath,
              height: 20,
            )),
        const SizedBox(
          height: 3,
        ),
        Text(
          '$count',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Color(0xffA5A5A5)),
        )
      ]),
    );
  }
}

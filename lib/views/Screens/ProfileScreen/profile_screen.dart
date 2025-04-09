import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/constants/TextStyle.dart';
import 'package:shop/models/TicketModel.dart';
import 'package:shop/models/User.dart';
import 'package:shop/services/API/api_ticket_service.dart';
import 'package:shop/services/stores.dart';
import 'package:shop/views/Screens/HomeScreen/widget/section_header_widget.dart';
import 'package:shop/views/Screens/ProfileScreen/menu_screen.dart';
import 'package:shop/views/Widgets/card_ticket_widget.dart';
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

  void _showMenuSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
          child: ListView(
            controller: controller,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              // Thêm các menu item ở đây
              _buildMenuItem(Icons.person, 'Thông tin cá nhân'),
              _buildMenuItem(Icons.history, 'Lịch sử giao dịch'),
              _buildMenuItem(Icons.help, 'Trợ giúp'),
              _buildMenuItem(Icons.logout, 'Đăng xuất', isLogout: true),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout() async {
    try {
      await Storage.clearUser();
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Đăng xuất thất bại: $e')));
    }
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
              onPressed: _showMenuSheet),
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
              sectionHeader('Vé Chưa Sử Dụng', 'Xem tất Cả', 0xFF3461FD,
                  '/list-ticket', true),
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

  Widget _buildMenuItem(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : null),
      title: Text(title, style: TextStyle(color: isLogout ? Colors.red : null)),
      onTap: () {
        Navigator.pop(context);
        if (isLogout) {
          // Xử lý đăng xuất
          _handleLogout();
        }
      },
    );
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

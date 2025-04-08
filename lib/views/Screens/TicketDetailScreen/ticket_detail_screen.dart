import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/TicketModel.dart';
import 'package:shop/models/User.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';
import 'package:shop/views/Widgets/postter_widget.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;
  const TicketDetailScreen({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const PageAppBarWidget(title: 'Chi Tiết vé'),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              CustomPaint(
                painter: TicketPainter(),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 620,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/logo/logo_text.svg',
                                height: 25,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'lầu 6 | Vạn Hạnh Mall, Sư Vạn Hạnh, Phường 10, Quận 10, TP.HCM',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 0.3,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(
                                  'assets/images/qr_code.png',
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Quét Mã QR Này Tại Quầy Giao Dịch Hoặc Điểm Soát Vé',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                ),
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                        _buildTicketInfoSection(),
                        _buildDivider(),
                        _buildSeatInfoSection(context),
                        _buildDivider(),
                        _buildCinemaInfoSection(context),
                        _buildDivider(),
                        _buildStatusSection(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildUserInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketInfoSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.5,
                child: TicketInfoWidget(
                  title: 'Tên Phim',
                  value: ticket.showtime!.movie!.title ?? 'N/A',
                ),
              ),
              TicketInfoWidget(
                title: 'Thời Gian',
                value: _formatShowtime(ticket.showtime?.startTime),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSeatInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TicketInfoWidget(
                title: 'Phòng Chiếu',
                value: ticket.showtime!.room!.name ?? 'N/A',
              ),
              TicketInfoWidget(
                title: 'Số Vé',
                value: '0${ticket.seats?.length ?? 0}',
              ),
              TicketInfoWidget(
                title: 'Số Ghế',
                value:
                    ticket.seats?.map((e) => e.seatNumber).join(', ') ?? 'N/A',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCinemaInfoSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.45,
                child: TicketInfoWidget(
                  title: 'Rạp Phim',
                  value: ticket.showtime!.cinema!.name ?? 'N/A',
                ),
              ),
              const TicketInfoWidget(
                title: 'Bắp Nước',
                value: '02 Bắp + 02 Nước',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Trạng Thái: Đã Sử Dụng',
            style: TextStyle(fontSize: 14, color: Color(0xffA5A5A5)),
          ),
          Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 0,
      thickness: 0.3,
      color: Colors.grey,
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      constraints: const BoxConstraints(minHeight: 160),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        border: Border.all(color: const Color(0xff3461FD), width: 0.8),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông Tin Người Đặt',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(height: 0, thickness: 0.3, color: Colors.grey),
          UserInfoWidget(title: 'Họ Và Tên', value: 'TestUser 1'),
          Divider(height: 0, thickness: 0.3, color: Colors.grey),
          UserInfoWidget(title: 'Số Điện Thoại', value: '023425332'),
          Divider(height: 0, thickness: 0.3, color: Colors.grey),
          UserInfoWidget(title: 'Email', value: 'TestUser1@gmail.com'),
        ],
      ),
    );
  }

  String _formatShowtime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${DateFormat('EEEE', 'vi').format(dateTime)}\n'
        '${DateFormat('dd/MM').format(dateTime)} | '
        '${DateFormat('HH:mm').format(dateTime)}';
  }
}

class UserInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  const UserInfoWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 14, color: Color(0xffA5A5A5)),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class TicketInfoWidget extends StatelessWidget {
  final String title;
  final String value;
  const TicketInfoWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Color(0xffA5A5A5)),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    const radius = 14.0;
    const notchRadius = 15.0;
    final notchHeight = size.height / 2;

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, notchHeight - notchRadius);
    path.arcToPoint(
      Offset(size.width, notchHeight + notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, notchHeight + notchRadius);
    path.arcToPoint(
      Offset(0, notchHeight - notchRadius),
      radius: const Radius.circular(notchRadius),
      clockwise: false,
    );
    path.close();

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    final borderPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3;
    canvas.drawPath(path, borderPaint);

    final dividerPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.4;

    const dashWidth = 6.0;
    const dashSpace = 5.0;
    double startX = notchRadius;
    final dividerY = notchHeight;

    while (startX < size.width - notchRadius - 3) {
      canvas.drawLine(
        Offset(startX, dividerY),
        Offset(startX + dashWidth, dividerY),
        dividerPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

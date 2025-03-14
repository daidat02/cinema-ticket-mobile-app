import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg
import 'package:shop/models/User.dart';

class MainAppBar extends StatefulWidget {
  final User? user; // Cho phép user có thể null

  const MainAppBar({super.key, this.user}); // Có thể không truyền user

  @override
  State<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.user == null
              ? ElevatedButton(
                  onPressed: () {
                    // Xử lý chuyển hướng đến trang đăng nhập
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3461FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ), // Màu nền nút
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  child: const Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                )
              : Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/user_icon.svg',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chào, ${widget.user!.name}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 63, 63, 63),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/member_icon.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            const Text('Member',
                                // widget.user!.membershipType,
                                style: TextStyle(fontSize: 12)),
                            const SizedBox(width: 10),
                            SvgPicture.asset(
                              'assets/icons/star_icon.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text("${widget.user!.totalReviews}",
                                style: const TextStyle(fontSize: 12)),
                            const SizedBox(width: 10),
                            SvgPicture.asset(
                              'assets/icons/ticket_icon.svg',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text("${widget.user!.ticketsBooked}",
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
          const SizedBox(width: 10),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                'assets/logo/logo_text.svg',
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

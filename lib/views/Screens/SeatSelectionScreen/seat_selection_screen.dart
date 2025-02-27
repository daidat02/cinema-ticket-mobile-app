import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/views/Widgets/btn_bottom_widget.dart';
import 'package:shop/views/Widgets/line_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String showtimeId;
  const SeatSelectionScreen({super.key, required this.showtimeId});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  // Controller cho việc phóng to thu nhỏ và di chuyển
  final TransformationController _transformationController =
      TransformationController();

  // Danh sách ghế được chọn
  final List<String> selectedSeats = [];

  // Dữ liệu mô phỏng danh sách ghế
  // true: ghế đã đặt, false: ghế còn trống
  final List<List<bool>> bookedSeats = List.generate(
    10, // 10 hàng
    (row) => List.generate(
      12, // 12 cột
      (col) => (row + col) % 5 == 0, // Một số ghế ngẫu nhiên đã được đặt
    ),
  );

  // Danh sách các chữ cái đại diện cho hàng
  final List<String> rowLabels = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J'
  ];

  // Giá vé (đơn giá)
  final int ticketPrice = 85000;

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  // Tính toán tổng tiền
  int get totalPrice => selectedSeats.length * ticketPrice;

  // Xử lý khi người dùng chọn/bỏ chọn ghế
  void toggleSeatSelection(int row, int col) {
    final seatId = '${rowLabels[row]}${col + 1}';
    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else {
        selectedSeats.add(seatId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình để tính toán kích thước ghế phù hợp
    final screenWidth = MediaQuery.of(context).size.width;
    // Tính kích thước ghế dựa trên chiều rộng màn hình
    final seatSize =
        (screenWidth - 80) / 14; // Chia cho 14 vì có 12 cột ghế + 2 cột nhãn

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBarWidget(title: 'Movie Ticket Quang Trung'),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Màn hình chiếu phim
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: const Text(
              'MÀN HÌNH',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Vùng danh sách ghế có thể phóng to, thu nhỏ và di chuyển
          Expanded(
            child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: 0.5,
              maxScale: 2.5,
              boundaryMargin: const EdgeInsets.all(100),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hiển thị danh sách ghế
                        ...List.generate(
                          bookedSeats.length,
                          (row) => Row(
                            mainAxisSize: MainAxisSize
                                .min, // Để tránh Row chiếm toàn bộ chiều rộng
                            children: [
                              // Hiển thị nhãn hàng
                              SizedBox(
                                width: 20,
                                child: Text(
                                  rowLabels[row],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Hiển thị các ghế trong một hàng
                              ...List.generate(
                                bookedSeats[row].length,
                                (col) {
                                  final seatId = '${rowLabels[row]}${col + 1}';
                                  final isBooked = bookedSeats[row][col];
                                  final isSelected =
                                      selectedSeats.contains(seatId);

                                  // Xác định màu sắc ghế dựa vào trạng thái
                                  Color seatColor;
                                  if (isBooked) {
                                    seatColor =
                                        const Color(0xff0079FF); // Đã đặt
                                  } else if (isSelected) {
                                    seatColor =
                                        const Color(0xff2C4FA8); // Đang chọn
                                  } else {
                                    seatColor =
                                        const Color(0xffD0D1D9); // Chưa đặt
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GestureDetector(
                                      onTap: isBooked
                                          ? null
                                          : () => toggleSeatSelection(row, col),
                                      child: Container(
                                        height: seatSize,
                                        width: seatSize,
                                        decoration: BoxDecoration(
                                          color: seatColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${col + 1}',
                                          style: TextStyle(
                                            color: isBooked || isSelected
                                                ? Colors.white
                                                : Colors.black54,
                                            fontSize: seatSize *
                                                0.4, // Điều chỉnh kích thước chữ theo kích thước ghế
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 10),
                              // Hiển thị nhãn hàng ở phía bên phải
                              SizedBox(
                                width: 20,
                                child: Text(
                                  rowLabels[row],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Các nút điều khiển thu phóng
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _transformationController.value = Matrix4.identity();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2C4FA8),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: const Icon(Icons.home, color: Colors.white),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final scale =
                          _transformationController.value.getMaxScaleOnAxis();
                      if (scale < 2.5) {
                        _transformationController.value.scale(1.2);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2C4FA8),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final scale =
                          _transformationController.value.getMaxScaleOnAxis();
                      if (scale > 0.5) {
                        _transformationController.value.scale(0.8);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2C4FA8),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: const Icon(Icons.remove, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
      bottomNavigationBar: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 70,
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Color(0xffDFDEE4),
                          width: 0.5,
                          style: BorderStyle.solid))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  seatTypeWidget(0xff0079FF, 'Đã đặt'),
                  seatTypeWidget(0xffD0D1D9, 'Chưa đặt'),
                  seatTypeWidget(0xff2C4FA8, 'Đang Chọn'),
                ],
              ),
            ),
            LineWidget(),
            Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 213, 25, 11),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              '18+',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            'Nhà Gia Tiên',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    '14:20 ~ 15:57 | Thứ 5, 27/2/2025 | 2D Phụ đề',
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  selectedSeats.isNotEmpty
                      ? Row(
                          children: [
                            const Text(
                              'Ghế: ',
                              style: TextStyle(fontSize: 13),
                            ),
                            Expanded(
                              child: Text(
                                selectedSeats.join(", "),
                                style: const TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tạm Tính'),
                      Text(
                        '${NumberFormat.decimalPattern().format(totalPrice)}đ',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
            ),
            BtnBottomWidget(
                title: 'Tiếp Tục',
                data: widget.showtimeId,
                onPressed: (String showtimeId) {
                  if (selectedSeats.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Vui lòng chọn ít nhất 1 ghế'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  Navigator.pushNamed(context, '/payment');
                }),
          ],
        ),
      ),
    );
  }

  Widget seatTypeWidget(int color, String type) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: Color(color),
              borderRadius: const BorderRadius.all(Radius.circular(4))),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          type,
          style: const TextStyle(fontSize: 13),
        )
      ],
    );
  }
}

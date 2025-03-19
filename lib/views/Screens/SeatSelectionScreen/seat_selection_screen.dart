import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/DetailShowtime.dart';
import 'package:shop/models/SeatModel.dart';
import 'package:shop/services/API/api_showtimes_service.dart';
import 'package:shop/views/Widgets/btn_bottom_widget.dart';
import 'package:shop/views/Widgets/line_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';

class SeatSelectionScreen extends StatefulWidget {
  final String showtimeId;
  const SeatSelectionScreen({super.key, required this.showtimeId});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final ShowtimesService _showtimesService = ShowtimesService();
  // Controller cho việc phóng to thu nhỏ và di chuyển
  final TransformationController _transformationController =
      TransformationController();

  DetailShowtime? detailShowtime;
  // Danh sách ghế được chọn
  final List<Seat> selectedSeats = [];
  final bool isSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetailShowtime(widget.showtimeId);
  }

  Future<void> loadDetailShowtime(showtimeId) async {
    LoadingOverlay.show(context);
    DetailShowtime loadDetailShowtime =
        await _showtimesService.loadDetailShowtime(showtimeId);

    if (mounted) {
      setState(() {
        detailShowtime = loadDetailShowtime;
      });
    }
    LoadingOverlay.hide();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  // Tính toán tổng tiền
  double totalPrice = 0;
  // Xử lý khi người dùng chọn/bỏ chọn ghế
  void toggleSeatSelection(seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
        totalPrice -= seat?.price;
      } else {
        selectedSeats.add(seat ?? '');
        totalPrice += seat?.price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PageAppBarWidget(title: detailShowtime?.cinema?.name ?? ''),
      body: Column(
        children: [
          // Màn hình chiếu phim
          Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/icons/line.png',
                  fit: BoxFit.contain,
                ),
                const Text(
                  'Màn Hình',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff2C4FA8)),
                )
              ],
            ),
          ),
          // Vùng danh sách ghế có thể phóng to, thu nhỏ và di chuyển
          Expanded(
            child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: 0.4, // Giảm tỷ lệ tối thiểu để linh hoạt hơn
              maxScale: 3.0, // Tăng tỷ lệ tối đa
              boundaryMargin: const EdgeInsets.all(
                  100), // Biên giới rộng hơn để di chuyển tự do
              panEnabled: true,
              scaleEnabled: true,
              constrained:
                  false, // Cho phép nội dung di chuyển ra ngoài giới hạn hiển thị

              onInteractionEnd: (details) {
                // Có thể thêm logic sau khi người dùng kết thúc tương tác
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width:
                    (detailShowtime?.room?.colNumber?.toDouble() ?? 10.0) * 50,
                height:
                    (detailShowtime?.room?.rowNumber?.toDouble() ?? 10.0) * 60,
                child: GridView.builder(
                  physics:
                      const NeverScrollableScrollPhysics(), // Ngăn GridView cuộn để tránh xung đột
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: detailShowtime?.room?.colNumber ?? 10,
                    crossAxisSpacing: 7.0,
                    mainAxisSpacing: 7.0,
                  ),
                  itemCount: detailShowtime?.room?.seats?.length ?? 0,
                  itemBuilder: (context, index) {
                    final seat = detailShowtime?.room?.seats?[index];

                    return GestureDetector(
                      onTap: () {
                        // Logic chọn ghế của bạn
                        detailShowtime?.bookedSeat?.contains(seat?.sId) ?? false
                            ? null
                            : // Nếu ghế đã đặt, không cho nhấn
                            toggleSeatSelection(seat);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          color: selectedSeats.contains(seat)
                              ? const Color(
                                  0xff2A4ECA) // Ghế đang chọn có màu xanh đậm
                              : (detailShowtime?.bookedSeat
                                          ?.contains(seat?.sId) ??
                                      false)
                                  ? const Color(0xff3461FD)
                                  : const Color(0xffD0D1D9), // Màu ghế mặc định
                        ),
                        child: Text(
                          seat?.seatNumber ?? "??",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ), // Các nút điều khiển thu phóng
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
                  seatTypeWidget(0xff3461FD, 'Đã đặt'),
                  seatTypeWidget(0xffD0D1D9, 'Chưa đặt'),
                  seatTypeWidget(0xff2A4ECA, 'Đang Chọn'),
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
                          Text(
                            detailShowtime?.movie?.title ?? "",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${DateFormat('HH:mm').format(detailShowtime?.startTime?.toLocal() ?? DateTime.now())} ~ ${DateFormat('HH:mm').format(detailShowtime?.startTime?.toLocal().add(Duration(minutes: detailShowtime?.movie?.duration ?? 0)) ?? DateTime.now())} | ${DateFormat('EEEE', 'vi').format(detailShowtime?.startTime?.toLocal() ?? DateTime.now())}, ${DateFormat('dd/MM/yyyy').format(detailShowtime?.startTime?.toLocal() ?? DateTime.now())} | 2D Phụ Đề',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                  } else {
                    Navigator.pushNamed(
                      context,
                      '/payment',
                      arguments: {
                        'detailShowtime': detailShowtime,
                        'selectedSeats': selectedSeats,
                        'totalPrice': totalPrice
                      },
                    );
                  }
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

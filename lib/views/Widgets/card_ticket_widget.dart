import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/models/TicketModel.dart';
import 'package:shop/views/Widgets/postter_widget.dart';

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
                          onPressed: () => {
                            Navigator.pushNamed(context, '/ticket-detail',
                                arguments: ticket)
                          },
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

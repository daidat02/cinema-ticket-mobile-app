import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';
import 'package:shop/views/Widgets/search_widget.dart';

class CinemaScreen extends StatefulWidget {
  const CinemaScreen({super.key});
  @override
  State<CinemaScreen> createState() => _CinemaState();
}

class _CinemaState extends State<CinemaScreen> {
  final List<Cinema> cinemas = [
    Cinema(
      name: "CGV Vincom Center",
      distance: "1.2 km",
      address: "Tầng 5, Vincom Center, 72 Lê Thánh Tôn, Q.1, TP.HCM",
      svgAsset: "assets/logo/logo_text.svg", // Đường dẫn đến file SVG
      isFavorite: true,
    ),
    Cinema(
      name: "BHD Star Phạm Hùng",
      distance: "3.5 km",
      address: "L4-Vincom 3/2, 3C Đường 3/2, Q.10, TP.HCM",
      svgAsset: "assets/logo/logo_text.svg", // Đường dẫn đến file SVG
      isFavorite: false,
    ),
    Cinema(
      name: "Galaxy Nguyễn Du",
      distance: "2.1 km",
      address: "116 Nguyễn Du, Q.1, TP.HCM",
      svgAsset: "assets/logo/logo_text.svg", // Đường dẫn đến file SVG
      isFavorite: false,
    ),
    Cinema(
      name: "Lotte Cinema Cantavil",
      distance: "5.7 km",
      address: "L7-Cantavil Premier, Xa lộ Hà Nội, Q.2, TP.HCM",
      svgAsset: "assets/logo/logo_text.svg", // Đường dẫn đến file SVG
      isFavorite: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: const PageAppBarWidget(
        title: 'Chọn Theo Rạp',
        showBackButton: false,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const SearchWidget(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cinemas.length,
              itemBuilder: (context, index) {
                return CinemaCard(cinema: cinemas[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Cinema {
  final String name;
  final String distance;
  final String address;
  final String svgAsset; // Thay đổi từ image sang svgAsset
  bool isFavorite;

  Cinema({
    required this.name,
    required this.distance,
    required this.address,
    required this.svgAsset,
    required this.isFavorite,
  });
}

class CinemaCard extends StatefulWidget {
  final Cinema cinema;

  const CinemaCard({super.key, required this.cinema});

  @override
  State<CinemaCard> createState() => _CinemaCardState();
}

class _CinemaCardState extends State<CinemaCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: SvgPicture.asset(
                    widget.cinema.svgAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.cinema.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.cinema.distance,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    widget.cinema.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.cinema.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.cinema.isFavorite = !widget.cinema.isFavorite;
                    });
                  },
                ),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on,
                    size: 18, color: Color(0xff3461FD)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.cinema.address,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

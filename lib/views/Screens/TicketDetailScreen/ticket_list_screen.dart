import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop/models/TicketModel.dart';
import 'package:shop/services/API/api_ticket_service.dart';
import 'package:shop/services/stores.dart';
import 'package:shop/views/Widgets/card_ticket_widget.dart';
import 'package:shop/views/Widgets/loading_widget.dart';
import 'package:shop/views/Widgets/page_appBar_widget.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});
  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  final ApiTicketService _ticketService = ApiTicketService();
  List<Ticket> _tickets = [];
  final bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    try {
      LoadingOverlay.show(context);
      await Future.delayed(const Duration(seconds: 1));
      final String? accessToken = await Storage.getAccessToken();
      final List<Ticket> tickets =
          await _ticketService.getTicketsByUserId(accessToken ?? '');

      setState(() {
        _tickets = tickets;
      });
      LoadingOverlay.hide();
    } catch (e) {
      setState(() {
        _errorMessage = 'Đã có lỗi xảy ra khi tải danh sách vé';
      });
      LoadingOverlay.hide();
      print('Error loading tickets: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBarWidget(title: 'Vé Của Tôi'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loadTickets,
              child: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    if (_tickets.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadTickets,
      child: ListView.separated(
        itemCount: _tickets.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          thickness: 1,
          color: Color.fromARGB(255, 233, 233, 233), // Màu xám nhạt
        ),
        itemBuilder: (context, index) {
          return TicketCardWidget(ticket: _tickets[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/ticket_icon1.svg',
            height: 120,
          ),
          const SizedBox(height: 20),
          const Text(
            'Bạn chưa có vé nào',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Hãy đặt vé để trải nghiệm những bộ phim hay nhất',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff3461FD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: const Text(
              'Đặt Vé Ngay',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

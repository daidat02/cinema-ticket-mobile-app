import 'package:flutter/material.dart';
import 'package:shop/models/TicketModel.dart';
import 'package:shop/services/API/api_payment_service.dart';
import 'package:shop/views/Screens/PaymentScreen/widgets/payment_success_screen.dart';
import 'package:shop/views/Widgets/toast_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VNPayScreen extends StatefulWidget {
  final String paymentUrl;

  const VNPayScreen({
    super.key,
    required this.paymentUrl,
  });

  @override
  State<VNPayScreen> createState() => _VNPayScreenState();
}

class _VNPayScreenState extends State<VNPayScreen> {
  final ApiPaymentService _paymentService = ApiPaymentService();
  late WebViewController _controller;
  bool _isLoading = true;
  bool _isProcessingPayment = false; // Thêm biến cờ để kiểm soát trạng thái

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Kiểm tra URL trả về từ VNPay
            if (request.url.contains('vnp_ResponseCode') &&
                !_isProcessingPayment) {
              _isProcessingPayment = true; // Đánh dấu đang xử lý
              _handlePaymentResult(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  Future<void> _handlePaymentResult(String url) async {
    try {
      final uri = Uri.parse(url);
      final queryString = uri.query;

      print("params: $uri");

      final response = await _paymentService.vnPayReturn(queryString);
      final responseCode = uri.queryParameters['vnp_ResponseCode'];

      if (!mounted) return;

      if ((responseCode == '00' || response['success'] == true)) {
        SuccessToastWidget.show(context, "Thanh toán thành công");

        // Sử dụng pushReplacement thay vì pop
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentSuccessScreen(
              ticketId: response['data']['ticketId'],
            ),
          ),
        );
      } else {
        SuccessToastWidget.show(context, "Thanh toán bị hủy hoặc thất bại");

        // Thêm delay nhỏ để đảm bảo animation hoàn thành
        await Future.delayed(const Duration(milliseconds: 300));

        if (mounted) {
          // Luôn sử dụng pushReplacement thay vì pop để tránh lỗi
          Navigator.pushReplacementNamed(context, '/');
        }
      }
    } catch (e) {
      print('Error handling payment result: $e');
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/');
      }
    } finally {
      _isProcessingPayment = false; // Reset trạng thái
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

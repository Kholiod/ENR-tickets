import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'success_screen.dart';
import 'ticket_screen.dart';

class PaymentWebView extends StatefulWidget {
  final String paymentKey;
  final Map<String, dynamic> data;

  const PaymentWebView({
    super.key,
    required this.paymentKey,
    required this.data,
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    final url =
        "https://accept.paymob.com/api/acceptance/iframes/1024472?payment_token=${widget.paymentKey}";

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.contains("success=true")) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => SuccessScreen(
                    nextScreen: TicketScreen(
                      from: widget.data['from'],
                      to: widget.data['to'],
                      train: widget.data['train'],
                      trainType: widget.data['trainType'],
                      coach: widget.data['coach'],
                      seat: widget.data['seat'],
                      time: "06:00 AM",
                      name: widget.data['name'],
                      price: widget.data['price'],
                      bookingType: widget.data['bookingType'],
                      ticketId: widget.data['ticketId'],
                    ),
                  ),
                ),
              );
              return NavigationDecision.prevent;
            }

            if (request.url.contains("success=false")) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Payment Failed")));
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: WebViewWidget(controller: controller),
    );
  }
}

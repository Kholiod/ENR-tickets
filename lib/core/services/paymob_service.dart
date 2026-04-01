import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymobService {
  static const String baseUrl = "https://accept.paymob.com/api";

  static const String apiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRFME56VXdPU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5xNkxTTWpvd0hMZWw0RHgxMHlERWxqcEltTjZzeTBvdFJWNUlydUJMVzFZMlBqU0V6OWZiNlFFRmNYZE11b0k3MnVBT0NLOG1jeXVJTkFpY2VNVVpsdw==";

  static const int cardIntegrationId = 5598973;
  static const int walletIntegrationId = 5599322;

  static Future<String> getAuthToken() async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/tokens"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"api_key": apiKey}),
    );

    final data = jsonDecode(response.body);
    return data["token"];
  }

  static Future<int> createOrder(String token, int amount) async {
    final response = await http.post(
      Uri.parse("$baseUrl/ecommerce/orders"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "auth_token": token,
        "delivery_needed": "false",
        "amount_cents": amount,
        "currency": "EGP",
        "items": [],
      }),
    );

    final data = jsonDecode(response.body);
    return data["id"];
  }

  static Future<String> getPaymentKey({
    required String token,
    required int orderId,
    required int amount,
    required String name,
    required int integrationId,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/acceptance/payment_keys"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "auth_token": token,
        "amount_cents": amount,
        "expiration": 3600,
        "order_id": orderId,
        "billing_data": {
          "first_name": name,
          "last_name": "User",
          "email": "test@test.com",
          "phone_number": "01000000000",
          "apartment": "NA",
          "floor": "NA",
          "street": "NA",
          "building": "NA",
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "Cairo",
          "country": "EG",
          "state": "NA",
        },
        "currency": "EGP",
        "integration_id": integrationId,
      }),
    );

    final data = jsonDecode(response.body);
    return data["token"];
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enr_tickets/core/services/paymob_service.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  Future<void> payWithPaymob({
    required String price,
    required String name,
    required String train,
    required String trainType,
    required String coach,
    required String seats,
    required int integrationId,
  }) async {
    emit(PaymentLoading());

    try {
      final amount = (double.parse(price) * 100).toInt();

      final token = await PaymobService.getAuthToken();
      final orderId = await PaymobService.createOrder(token, amount);

      final paymentKey = await PaymobService.getPaymentKey(
        token: token,
        orderId: orderId,
        amount: amount,
        name: name,
        integrationId: integrationId,
      );

      final paymentUrl =
          "https://accept.paymob.com/api/acceptance/iframes/1024472?payment_token=$paymentKey";

      final ticketId =
          "${train}_${seats}_${DateTime.now().millisecondsSinceEpoch}";

      emit(
        PaymentSuccess(
          ticketId: ticketId,
          train: train,
          trainType: trainType,
          coach: coach,
          seat: seats,
          price: price,
          name: name,
          paymentUrl: paymentUrl,
          paymentKey: paymentKey,
        ),
      );
    } catch (_) {
      emit(PaymentError());
    }
  }
}

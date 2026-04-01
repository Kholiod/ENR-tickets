part of 'payment_cubit.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String ticketId;
  final String train;
  final String trainType;
  final String coach;
  final String seat;
  final String price;
  final String name;
  final String? paymentUrl;
  final String? paymentKey;

  PaymentSuccess({
    required this.ticketId,
    required this.train,
    required this.trainType,
    required this.coach,
    required this.seat,
    required this.price,
    required this.name,
    this.paymentUrl,
    this.paymentKey,
  });
}

class PaymentError extends PaymentState {}

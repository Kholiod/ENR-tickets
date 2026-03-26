import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/widgets/custom_divider.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/widgets/custom_text.dart';
import 'package:enr_tickets/features/payment_way/presentation/manager/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:enr_tickets/features/payment_way/presentation/view/payment_screens/card_payment_screen.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/payment_screens/wallet_screen.dart';
import 'package:enr_tickets/features/payment_way/presentation/view/payment_screens/instapay_screen.dart';

class PaymentWay extends StatelessWidget {
  final String train;
  final String trainType;
  final String coach;
  final List seats;

  const PaymentWay({
    super.key,
    required this.train,
    required this.trainType,
    required this.coach,
    required this.seats,
  });

  /// 💰 حساب السعر
  int getSeatPrice() {
    if (train == "185") return 75;
    if (train == "2009") return 150;
    if (train == "2031") return 200;
    return 100;
  }

  /// 🔥 الكارد
  Widget paymentItem(BuildContext context, String title, String imagePath) {
    final provider = Provider.of<PaymentProvider>(context);

    bool isSelected = provider.selectedMethod == title;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          provider.selectMethod(title);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 110,
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(10),
          transform: isSelected
              ? (Matrix4.identity()..scale(1.05))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? Colors.red : Colors.grey.shade300,
              width: 2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Radio<String>(
                  value: title,
                  groupValue: provider.selectedMethod,
                  onChanged: (value) {
                    provider.selectMethod(value!);
                  },
                  activeColor: Colors.red,
                ),
              ),
              Expanded(
                child: Center(
                  child: Image.asset(imagePath, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentProvider>(context);

    /// 💰 السعر الكلي
    final totalPrice = seats.length * getSeatPrice();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Complete Payment",
          style: Styles.textStyle20.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: appbarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),

              /// Title
              Center(
                child: CustomText(
                  title: "Complete Payment",
                  stylestitle: Styles.textStyle27,
                ),
              ),

              const Gap(20),
              CustomDivider(),

              /// 💰 Amount
              const Gap(20),
              Center(
                child: Text(
                  "$totalPrice EGP",
                  style: Styles.textStyle27.copyWith(color: Colors.red),
                ),
              ),

              const Gap(20),
              CustomDivider(),

              /// Choose method
              const Gap(20),
              CustomText(
                title: "Choose Payment Method",
                stylestitle: Styles.textStyle20,
              ),

              /// 💳 Bank Cards
              const Gap(20),
              const Text("Bank Cards"),
              Row(
                children: [
                  paymentItem(context, "Visa", "assets/images/visa.png"),
                  paymentItem(
                    context,
                    "MasterCard",
                    "assets/images/mastercard.png",
                  ),
                  paymentItem(context, "Meeza", "assets/images/meeza.png"),
                ],
              ),

              /// 📱 Wallets
              const Gap(20),
              const Text("Mobile Wallets"),
              Row(
                children: [
                  paymentItem(
                    context,
                    "Vodafone",
                    "assets/images/vodafone.png",
                  ),
                  paymentItem(
                    context,
                    "Etisalat",
                    "assets/images/etisalat.png",
                  ),
                  paymentItem(context, "Orange", "assets/images/orange.png"),
                ],
              ),

              /// ⚡ InstaPay
              const Gap(20),
              const Text("InstaPay"),
              Row(
                children: [
                  paymentItem(
                    context,
                    "InstaPay",
                    "assets/images/instapay.png",
                  ),
                ],
              ),

              /// 🧾 Fawry
              const Gap(20),
              const Text("Fawry"),
              Row(
                children: [
                  paymentItem(context, "Fawry", "assets/images/fawry.png"),
                ],
              ),

              const Gap(30),

              /// 🔥 Pay Now
              GestureDetector(
                onTap: () {
                  if (provider.selectedMethod.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a payment method"),
                      ),
                    );
                    return;
                  }

                  /// 💳 Card
                  if (provider.selectedMethod == "Visa" ||
                      provider.selectedMethod == "MasterCard" ||
                      provider.selectedMethod == "Meeza") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CardPaymentScreen(
                          train: train,
                          trainType: trainType,
                          coach: coach,
                          seats: seats,
                          price: totalPrice.toString(),
                        ),
                      ),
                    );
                  }
                  /// 📱 Wallet
                  else if (provider.selectedMethod == "Vodafone" ||
                      provider.selectedMethod == "Etisalat" ||
                      provider.selectedMethod == "Orange") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WalletScreen(
                          train: train,
                          trainType: trainType,
                          coach: coach,
                          seats: seats,
                          price: totalPrice.toString(),
                        ),
                      ),
                    );
                  }
                  /// ⚡ InstaPay
                  else if (provider.selectedMethod == "InstaPay") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InstaPayScreen(
                          train: train,
                          trainType: trainType,
                          coach: coach,
                          seats: seats,
                          price: totalPrice.toString(),
                        ),
                      ),
                    );
                  }
                  /// 🧾 Fawry
                  else if (provider.selectedMethod == "Fawry") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Go to nearest Fawry branch"),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: appbarColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      "Pay Now",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

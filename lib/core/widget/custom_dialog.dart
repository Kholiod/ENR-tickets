import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:enr_tickets/core/utils/colors.dart';
import 'package:enr_tickets/core/widget/styles.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  /// Shows a dialog
  static void show({
    required BuildContext context,
    String title = "Warning",
    String description = "Please select a seat first",
    DialogType dialogType = DialogType.warning,
    Color? borderColor,
    Color? btnOkColor,
    void Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      borderSide: BorderSide(color: borderColor ?? buttonColor, width: 2.2),

      width: MediaQuery.of(context).size.width * 0.8,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(15)),

      headerAnimationLoop: false,
      animType: AnimType.scale,
      dialogBackgroundColor: formColor,
      title: title,
      titleTextStyle: Styles.textStyle19,
      descTextStyle: Styles.textStyle17,
      desc: description,
      showCloseIcon: false,
      btnOkText: "OK",

      btnOkOnPress: btnOkOnPress,
      btnOkColor: btnOkColor ?? buttonColor,
      btnOkIcon: Icons.check,
    ).show();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list_flutter/text_style.dart';

import 'colors.dart';

showSnackBar({required String title, required String message}) {
  if (!Get.isSnackbarOpen) {
    return Get.snackbar(title, message,
        backgroundColor: Colors.transparent,
        onTap: (_) {},
        shouldIconPulse: true,
        barBlur: 0,
        isDismissible: true,
        userInputForm: Form(
            child: Wrap(
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: title == "Success" ? color4AA900 : colorB3261E,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12.withOpacity(0.15), blurRadius: 20)]),
                    child: Wrap(children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(color: colorFFFFFF, borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                //  Image.asset(title == ApiConfig.success ? 'assets/icon/success.png' : 'assets/icon/error.png', scale: 4),
                                const SizedBox(width: 5),
                                CustomText(txtTitle: title, style: title == "Success" ? color4AA900w60016 : colorB3261Ew60016)
                              ],
                            ),
                            const SizedBox(height: 15),
                            CustomText(txtTitle: message, style: color4AA900w50014.copyWith(color: title == "Success" ? color4AA900 : colorB3261E), textOverflow: TextOverflow.visible)
                          ],
                        ),
                      )
                    ]))
              ],
            )),
        borderRadius: 0,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        //boxShadows: <BoxShadow>[BoxShadow(color: Colors.black12.withOpacity(0.15), blurRadius: 16)],
        duration: const Duration(seconds: 2));
  }
}

class CustomText extends StatelessWidget {
  final String txtTitle;
  final TextStyle? style;
  final TextAlign align;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final Widget? icon;
  final Function()? onTap;

  const CustomText({super.key, required this.txtTitle, this.style, this.align = TextAlign.start, this.maxLine, this.onTap, this.icon, this.textOverflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? TextButton.icon(
        style: ButtonStyle(padding: WidgetStateProperty.all(EdgeInsets.zero)),
        onPressed: onTap,
        icon: icon ?? const SizedBox(),
        label: Text(txtTitle, style: style, softWrap: true, textAlign: align, maxLines: maxLine, overflow: textOverflow))
        : Text(txtTitle, style: style, softWrap: true, textAlign: align, maxLines: maxLine, overflow: textOverflow);
  }
}

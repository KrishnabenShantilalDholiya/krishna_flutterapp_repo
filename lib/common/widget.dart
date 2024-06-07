// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'color.dart';

class SizeConfig {
  static getHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static getWidth(context) {
    return MediaQuery.of(context).size.width;
  }
}

Widget appText({
  String? title,
  FontWeight? fontWeight,
  double? fontSize,
  double? letterSpacing,
  FontStyle? fontStyle,
  Color? color,
  TextAlign? textAlign,
  int? maxLines,
  double? height,
  decoration,
}) {
  return Text(
    title!,
    textAlign: textAlign,
    style: TextStyle(
        height: height,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'Roboto',
        color: color,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        decoration: decoration ?? TextDecoration.none),
  );
}

Widget customButton({
  String? title,
  VoidCallback? onTap,
  Color? color,
  Color? borderColor,
  Color? textColor,
  double? margin,
  double? textSize,
  dynamic width,
  dynamic height,
  verticalmargin,
  double? radius,
  Widget? icon,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 60,
      width: 180,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(
          horizontal: margin ?? 0, vertical: verticalmargin ?? 9),
      decoration: BoxDecoration(
          color: color ?? const Color(0xFFEBEAEC),
          borderRadius: BorderRadius.circular(radius ?? 20),
          border: Border.all(
            color: const Color(0xFFACAAA0),
            style: BorderStyle.solid,
            width: Get.width * 0.0,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3F414E).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          Text(
            title!,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: textSize ?? 15,
              color: textColor,
              letterSpacing: 0.7,
            ),
          )
        ],
      ),
    ),
  );
}

Widget textField(
    {hint,
    image,
    maxLines,
    keyboardType,
    validator,
    title,
    minline,
    controller,
    suffixIcon,
    obscureText,
    prefixIcon,
    readOnly,
    onTap,
    inputFormatters,
    horizontalpadding,
    verticalpading,
    onEditingComplete,
    textInputAction,
    onChanged,
    backgroundcolor}) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: AppColor.black,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      Container(
        // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFACAAA0)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [BoxShadow(color: Colors.blueGrey[50]!, blurRadius: 2)],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            cursorColor: AppColor.primary,
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            onTap: onTap,
            validator: validator,
            keyboardType: keyboardType,
            controller: controller,
            inputFormatters: inputFormatters,
            autofocus: false,
            textInputAction: textInputAction ?? TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.2,
                color: AppColor.black,
                fontFamily: 'Roboto'),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              icon: prefixIcon,
              hintText: hint,
              errorMaxLines: 2,
              errorStyle: const TextStyle(fontSize: 14),
              hintStyle:
                  const TextStyle(color: Color(0xFFA1A4B2), fontSize: 18),
              border: InputBorder.none,
            ),
            // textCapitalization: TextCapitalization.sentences,
          ),
        ),
      ),
    ],
  );
}

Widget textField2(
    {hint,
    image,
    maxLines,
    keyboardType,
    validator,
    title,
    minline,
    controller,
    suffixIcon,
    obscureText,
    prefixIcon,
    readOnly,
    onTap,
    inputFormatters,
    horizontalpadding,
    verticalpading,
    onEditingComplete,
    textInputAction,
    onChanged,
    backgroundcolor}) {
  return Column(
    children: [
      Container(
        // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFACAAA0)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [BoxShadow(color: Colors.blueGrey[50]!, blurRadius: 1)],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            cursorColor: AppColor.primary,
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            onTap: onTap,
            validator: validator,
            keyboardType: keyboardType,
            controller: controller,
            inputFormatters: inputFormatters,
            autofocus: false,
            textInputAction: textInputAction ?? TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            style: TextStyle(
                fontSize: 14, letterSpacing: 0.2, color: AppColor.black),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              icon: prefixIcon,
              hintText: hint,
              errorMaxLines: 2,
              errorStyle: const TextStyle(fontSize: 10),
              hintStyle:
                  const TextStyle(color: Color(0xFF757570), fontSize: 14),
              border: InputBorder.none,
            ),
            // textCapitalization: TextCapitalization.sentences,
          ),
        ),
      ),
    ],
  );
}

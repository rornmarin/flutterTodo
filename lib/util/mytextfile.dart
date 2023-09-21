// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MytextFile extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onchanged;
  final String? hintText;
  final bool obscursText;
  final String? initail;
  const MytextFile({
    Key? key,
    this.initail,
    this.controller,
    required this.hintText,
    required this.obscursText,
    this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onChanged: onchanged,
        controller: controller,
        obscureText: obscursText,
        initialValue: initail,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[300])),
      ),
    );
  }
}

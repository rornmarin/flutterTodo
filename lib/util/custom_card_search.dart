// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomcardSearch extends StatefulWidget {
  final Function(String)? onChanged;
  const CustomcardSearch({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomcardSearch> createState() => _CustomcardSearchState();
}

class _CustomcardSearchState extends State<CustomcardSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.5,
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        color: Colors.white,
      ),
      child: TextField(
        // controller: controller.searchEditingController.value,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 20.0,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            height: 2.2,
            color: Colors.grey.withOpacity(0.5),
          ),
          suffixIcon: const Icon(
            Icons.cancel_outlined,
            size: 20.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

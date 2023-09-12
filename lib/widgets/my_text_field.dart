import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool enabled;
  const MyTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 40),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              title,
              style: GoogleFonts.lato(fontSize: 16),
            ),
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              border: InputBorder.none,
            ),
            style: GoogleFonts.lato(fontSize: 18),
            enabled: enabled,
          ),
        ],
      ),
    );
  }
}

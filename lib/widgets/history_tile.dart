import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  final String date;
  final String present;
  final void Function()? onTap;

  const HistoryTile({
    super.key,
    required this.date,
    required this.onTap,
    required this.present,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  present,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

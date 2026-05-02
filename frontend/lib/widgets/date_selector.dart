import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/features/features.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HistoryProvider>();

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Date: ${provider.selectedDate.toLocal().toString().split(" ")[0]}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(width: 20),

            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: provider.selectedDate,
                  firstDate: DateTime(2024),
                  lastDate: DateTime.now(),
                );

                if (picked != null) {
                  provider.selectedDate = picked;
                  await provider.loadByDate();
                }
              },
              child: const Text("Select Date"),
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
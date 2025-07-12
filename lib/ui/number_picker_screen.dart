import 'package:flutter/material.dart';

class NumberPickerScreen extends StatefulWidget {
  const NumberPickerScreen({super.key});

  @override
  State<NumberPickerScreen> createState() => _NumberPickerScreenState();
}

class _NumberPickerScreenState extends State<NumberPickerScreen> {
  final List<int> selectedNumbers = [];

  void toggleNumber(int number) {
    setState(() {
      if (selectedNumbers.contains(number)) {
        selectedNumbers.remove(number);
      } else {
        if (selectedNumbers.length < 6) {
          selectedNumbers.add(number);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chọn 6 số (1–45)')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(45, (index) {
              final number = index + 1;
              final isSelected = selectedNumbers.contains(number);
              return GestureDetector(
                onTap: () => toggleNumber(number),
                child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$number',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: selectedNumbers.length == 6
                ? () {
              // TODO: Gửi selectedNumbers để kiểm tra kết quả
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Bộ số đã chọn'),
                  content: Text(selectedNumbers.join(', ')),
                ),
              );
            }
                : null,
            child: const Text('✅ Xác nhận'),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayedSet {
  final List<int> numbers;
  final DateTime createdTime;

  PlayedSet(this.numbers, this.createdTime);
}

class NumberPicker655Screen extends StatefulWidget {
  const NumberPicker655Screen({super.key});

  @override
  State<NumberPicker655Screen> createState() => _NumberPicker655ScreenState();
}

class _NumberPicker655ScreenState extends State<NumberPicker655Screen> {
  final List<int?> currentNumbers = List.filled(6, null);
  final List<PlayedSet> playedSets = [];

  void _pickNumberSet() async {
    final pickedSet = await showDialog<List<int>>(
      context: context,
      builder: (_) => NumberSelectionDialog(
        initialSelected: currentNumbers.whereType<int>().toList(),
      ),
    );
    if (pickedSet != null && pickedSet.length == 6) {
      setState(() {
        for (int i = 0; i < 6; i++) {
          currentNumbers[i] = pickedSet[i];
        }
      });
    }
  }


  void _confirmSet() {
    final completedSet = currentNumbers.whereType<int>().toList();
    if (completedSet.length == 6) {
      setState(() {
        playedSets.insert(0, PlayedSet(List.from(completedSet), DateTime.now()));
        for (int i = 0; i < 6; i++) {
          currentNumbers[i] = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vietlott 6/55')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 12,
              children: List.generate(6, (index) {
                final number = currentNumbers[index];
                return GestureDetector(
                  onTap: _pickNumberSet, // Bấm vào bất kỳ ô nào đều mở dialog
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: number != null ? Colors.blue : Colors.grey[300],
                    child: Text(
                      number?.toString() ?? '?',
                      style: TextStyle(
                        fontSize: 20,
                        color: number != null ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: currentNumbers.whereType<int>().length == 6 ? _confirmSet : null,
              child: const Text('✅ Xác nhận bộ số'),
            ),
            const SizedBox(height: 24),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: playedSets.length,
                itemBuilder: (context, index) {
                  final set = playedSets[index];
                  final formattedTime = DateFormat('dd/MM/yyyy HH:mm').format(set.createdTime);
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(set.numbers.join(', ')),
                      subtitle: Text('🕒 $formattedTime'),
                      trailing: TextButton(
                        onPressed: () {
                          // TODO: xử lý kiểm tra trùng sau
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Chức năng kiểm tra đang phát triển')),
                          );
                        },
                        child: const Text('Kiểm tra trùng'),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NumberSelectionDialog extends StatefulWidget {
  final List<int> initialSelected;

  const NumberSelectionDialog({super.key, required this.initialSelected});

  @override
  State<NumberSelectionDialog> createState() => _NumberSelectionDialogState();
}

class _NumberSelectionDialogState extends State<NumberSelectionDialog> {
  late List<int> selected;

  @override
  void initState() {
    super.initState();
    selected = List.from(widget.initialSelected);
  }

  void toggleNumber(int number) {
    setState(() {
      if (selected.contains(number)) {
        selected.remove(number);
      } else {
        if (selected.length < 6) {
          selected.add(number);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chọn 6 số (1–55)'),
      content: SingleChildScrollView(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(55, (index) {
            final number = index + 1;
            final isSelected = selected.contains(number);
            return GestureDetector(
              onTap: () => toggleNumber(number),
              child: Container(
                width: 40,
                height: 40,
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
      ),
      actions: [
        TextButton(
          onPressed: selected.length == 6
              ? () {
            Navigator.of(context).pop(selected);
          }
              : null,
          child: const Text('✅ Xác nhận'),
        ),
      ],
    );
  }
}


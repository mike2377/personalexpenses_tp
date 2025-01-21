import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BarChart extends StatelessWidget {
  

  const BarChart({super.key});

  List<Map<String, Object>> get groupe {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
      };
    }).reversed.toList();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupe.map((data) {
            return Flexible(
              child: Column(
                children: [
                  const FittedBox(
                    child: Text(
                      '\$',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 60,
                    width: 10,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data['day'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

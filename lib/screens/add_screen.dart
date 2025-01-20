import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {

    final void Function(String title, double amount, DateTime date) addTransaction;
    const AddScreen({super.key, required this.addTransaction});

    @override
    State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

    final _title = TextEditingController();
    final _amount = TextEditingController();
    DateTime? _selectedDate;

    void _valider() {

        final title = _title.text;
        final amount = double.tryParse(_amount.text);
        if (title.isEmpty || amount == null || _selectedDate == null) {
            return;
        }
        widget.addTransaction(title, amount, _selectedDate!);
        _title.clear();
        _amount.clear();
        _selectedDate = null;
        Navigator.pop(context);

    }

    void datePicker(){
        showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime(2023),
            lastDate: DateTime.now(),
        ).then((value) {
            if (value!= null) {
                _selectedDate = value;
            }
        });
    }


    @override
    Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                TextField(
                    controller: _title,
                    decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                    controller: _amount,
                    decoration: const InputDecoration(labelText: 'Amount'
                    ),

                ),
                const Spacer(),
                Row(
                    children: [
                    const Text('Date Chosen '),
                    Expanded(
                        child: GestureDetector(
                            onTap: datePicker,
                            child: Text(
                                _selectedDate?.toString()?? 'Chose Date',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple,
                                ),
                                textAlign: TextAlign.end,
                            ),
                            
                        ),
                    ),
                    ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: _valider,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                    ),
                    child: const Text(
                        'Add Transaction',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ),
                ],
            ),
        ),

    );
    }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testa/models/transaction.dart';
import 'package:testa/screens/add_screen.dart';
import 'package:testa/chart/barchart.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  void _addTransaction(String title, double amount, DateTime date) {
    setState(() {
      _transaction.add(Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: date));
    });
  }


  void _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((transaction) => transaction.id == id);
      });

  }


  void _newTransactionForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddScreen(
          addTransaction: _addTransaction,
          );
          }
          
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            "Personal Expenses",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _newTransactionForm,
              color: Colors.white,
            ),
          ]
        ),
        body: Column(
          children: [
            const WeeklyBarChart(),
            
            Expanded(
                child: ListView.builder(
                    itemCount: _transaction.length,
                    itemBuilder: (context, index) {
                      final t = _transaction[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.purple,
                            child: FittedBox(
                              child: Text(
                                '\$${t.amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ),
                          ),
                          title: Text(
                            t.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(DateFormat('MMM dd, yyyy').format(t.date)),
                          trailing: IconButton(
                            color: Colors.red,
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteTransaction(t.id);
                            },
                          ),
                          ),
                      );
                    }))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _newTransactionForm,
          child: const Icon(Icons.add),
        ));
  }
}

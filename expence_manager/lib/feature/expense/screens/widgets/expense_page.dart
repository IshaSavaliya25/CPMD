import 'package:expence_manager/feature/expense/models/transaction.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<Transaction> transactions = [];

  TextEditingController titleTxtCntrl = TextEditingController();
  TextEditingController amountTxtCntrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense App')),
      body: Column(
        children: [
          // add expense
          Column(
            children: [
              TextField(
                controller: titleTxtCntrl,
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: amountTxtCntrl,
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleTxtCntrl.text.isNotEmpty &&
                      amountTxtCntrl.text.isNotEmpty) {
                    transactions.add(
                      Transaction(
                        title: titleTxtCntrl.text,
                        amount: double.parse(amountTxtCntrl.text),
                      ),
                    );
                    titleTxtCntrl.clear();
                    amountTxtCntrl.clear();
                    setState(() {});
                    print(transactions.length);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
          // dispaly expenses
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) => Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${transactions[index].title}'),
                    Text('${transactions[index].amount}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget transactionItemCard 
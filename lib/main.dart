import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Thing',
      home: MyHomePage(title: 'Finances'),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.amber,
        appBarTheme: const AppBarTheme(color: Colors.green),
        textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
            bodyText2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            button: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  double sliderValue = 50;

  void startAddNewTransaction(BuildContext ctx) async {
    await Future.delayed(Duration(seconds: 2));
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _addNewTransaction(String title, int amount, DateTime date) {
    final newTransaction = Transaction(
      title: title,
      amountInPennies: amount,
      id: UniqueKey().toString(),
      date: date,
    );
    setState(() {
      _userTransactions.add(newTransaction);
    });

    Transaction(
      date: DateTime.now(),
      id: 'not real',
      title: 'cascade',
      amountInPennies: 23,
    )
      ..printTransaction()
      ..printTransaction()
      ..printTransaction();
  }

  void _removeTransaction(String key) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == key);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my app'),
        actions: [
          IconButton(
            onPressed: () {
              startAddNewTransaction(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                child: Chart(_userTransactions),
              ),
              Placeholder(
                color: Colors.red,
                fallbackHeight: 100,
              ),
              Divider(
                color: Colors.grey,
              ),
              _userTransactions.isEmpty
                  ? Column(children: [
                      Text('No Transactions Yet'),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 220,
                        height: 220,
                        child: Image.asset(
                          'assets/empty.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ])
                  : TransactionList(_userTransactions, _removeTransaction),
            ],
          ),
        ),
      ),
    );
  }
}

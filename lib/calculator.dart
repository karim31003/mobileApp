import 'package:flutter/material.dart';
import 'dart:math';



class CarCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Affordability Calculator',
      theme: ThemeData(
        primaryColor: Color(0xFF1877F2),
        // scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          // elevation: 1,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF0F2F5),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: CarCalculatorPage(),
    );
  }
}

class CarCalculatorPage extends StatefulWidget {
  @override
  _CarCalculatorPageState createState() => _CarCalculatorPageState();
}

class _CarCalculatorPageState extends State<CarCalculatorPage> {
  final _carPriceController = TextEditingController();
  final _monthlyIncomeController = TextEditingController();
  final _acceptableRateController = TextEditingController();
  final _downPaymentController = TextEditingController();

  int _installmentMonths = 12;
  String _result = '';

  final List<Map<String, dynamic>> _installmentOptions = [
    {'label': '6 months - 5% interest ', 'value': 6, 'rate': 5.0},
    {'label': '12 months - 8% interest', 'value': 12, 'rate': 8.0},
    {'label': '24 months - 12% interest', 'value': 24, 'rate': 12.0},
    {'label': '36 months - 16% interest', 'value': 36, 'rate': 16.0},
    {'label': '48 months - 20% interest ', 'value': 48, 'rate': 20.0},
  ];

  void _calculateAffordability() {
    final carPrice = double.tryParse(_carPriceController.text);
    final monthlyIncome = double.tryParse(_monthlyIncomeController.text);
    final rateLimit = double.tryParse(_acceptableRateController.text);
    final downPayment = double.tryParse(_downPaymentController.text) ?? 0;

    if (carPrice == null || monthlyIncome == null || rateLimit == null) {
      setState(() {
        _result = '❌ Please enter all valid inputs.';
      });
      return;
    }

    final maxAffordablePayment = monthlyIncome * (rateLimit / 100);
    final selectedOption = _installmentOptions.firstWhere(
            (option) => option['value'] == _installmentMonths);
    final interestRate = selectedOption['rate'] / 100 / 12;
    final n = _installmentMonths;
    final loanAmount = carPrice - downPayment;

    final monthlyPayment = loanAmount *
        (interestRate * pow(1 + interestRate, n)) /
        (pow(1 + interestRate, n) - 1);

    final totalPrice = monthlyPayment * n + downPayment;

    setState(() {
      _result = monthlyPayment <= maxAffordablePayment
          ? ' You can afford this car.\n\n'
          '• Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}\n'
          '• Total Paid: \$${totalPrice.toStringAsFixed(2)}\n'
          '• Down Payment: \$${downPayment.toStringAsFixed(2)}\n'
          '• Interest Rate: ${selectedOption['rate']}%\n\n'
          ' Shorter durations = less interest!'
          : ' This car exceeds your affordable monthly rate.\n\n'
          '• Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}\n'
          '• Your Max Affordable: \$${maxAffordablePayment.toStringAsFixed(2)}\n'
          'Try reducing the price or choosing a shorter plan.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Affordability Calculator'),
      
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _carPriceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Car Price'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _downPaymentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Down Payment (Optional)'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _monthlyIncomeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Your Monthly Income'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _acceptableRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Allowed % of Income for Payment'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: _installmentMonths,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Installment Duration',
              ),
              items: _installmentOptions.map((option) {
                return DropdownMenuItem<int>(
                  value: option['value'],
                  child: Text(option['label']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _installmentMonths = value!;
                });
              },
            ),
            SizedBox(height: 25),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                ),
                onPressed: _calculateAffordability,
                // icon: Icon(Icons.check_circle_outline),
                label: Text(
                  'Check Affordability',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (_result.isNotEmpty)
              Card(
                color: _result.contains('❌') ? Colors.red[50] : Colors.green[50],
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    _result,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                      _result.contains('❌') ? Colors.red : Colors.green[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

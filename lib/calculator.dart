import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CarCalculatorApp());
}

class CarCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Affordability Calculator',
      theme: ThemeData(
        primaryColor: Color(0xFF1877F2),
        scaffoldBackgroundColor: Color(0xFFEAF3FB),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1877F2),
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF1877F2),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: Color(0xFF1877F2), fontWeight: FontWeight.w600),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF1877F2), fontSize: 16),
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
    {'label': '6 months - 5% interest 🌟', 'value': 6, 'rate': 5.0},
    {'label': '12 months - 8% interest', 'value': 12, 'rate': 8.0},
    {'label': '24 months - 12% interest', 'value': 24, 'rate': 12.0},
    {'label': '36 months - 16% interest', 'value': 36, 'rate': 16.0},
    {'label': '48 months - 20% interest', 'value': 48, 'rate': 20.0},
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
          (option) => option['value'] == _installmentMonths,
    );
    final interestRate = selectedOption['rate'] / 100 / 12;
    final n = _installmentMonths;
    final loanAmount = carPrice - downPayment;

    final monthlyPayment = loanAmount *
        (interestRate * pow(1 + interestRate, n)) /
        (pow(1 + interestRate, n) - 1);

    final totalPrice = monthlyPayment * n + downPayment;

    setState(() {
      _result = monthlyPayment <= maxAffordablePayment
          ? '✅ You can afford this car.\n\n'
          '• Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}\n'
          '• Total Paid: \$${totalPrice.toStringAsFixed(2)}\n'
          '• Down Payment: \$${downPayment.toStringAsFixed(2)}\n'
          '• Interest Rate: ${selectedOption['rate']}%\n\n'
          '💡 Shorter durations = less interest!'
          : '❌ This car exceeds your affordable monthly rate.\n\n'
          '• Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}\n'
          '• Your Max Affordable: \$${maxAffordablePayment.toStringAsFixed(2)}\n'
          'Try reducing the price or choosing a shorter plan.';
    });
  }

  Widget _buildInputCard({
    required IconData icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Color(0xFF1877F2)),
          decoration: InputDecoration(
            icon: Icon(icon, color: Color(0xFF1877F2)),
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF90C0F4),
      
      appBar: AppBar(
        title: Text('Car Calculator'),
        foregroundColor: Color(0xFF1877F2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
        child: ListView(
          children: [
            _buildInputCard(
              icon: Icons.directions_car,
              label: 'Car Price',
              controller: _carPriceController,
            ),
            _buildInputCard(
              icon: Icons.attach_money,
              label: 'Down Payment (Optional)',
              controller: _downPaymentController,
            ),
            _buildInputCard(
              icon: Icons.account_balance_wallet,
              label: 'Monthly Income',
              controller: _monthlyIncomeController,
            ),
            _buildInputCard(
              icon: Icons.percent,
              label: 'Affordable % of Income',
              controller: _acceptableRateController,
              
            ),
            SizedBox(height: 12),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: DropdownButtonFormField<int>(
                  value: _installmentMonths,
                  decoration: InputDecoration(
                    labelText: 'Installment Duration',
                    labelStyle: TextStyle(color: Color(0xFF1877F2), fontWeight: FontWeight.w600),
                    border: InputBorder.none,
                  ),
                  dropdownColor: Colors.white,
                  iconEnabledColor: Color(0xFF1877F2),
                  style: TextStyle(color: Color(0xFF1877F2)),
                  items: _installmentOptions.map((option) {
                    return DropdownMenuItem<int>(
                      value: option['value'],
                      child: Text(option['label'], style: TextStyle(color: Color(0xFF1877F2))),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _installmentMonths = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1877F2),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                ),
                onPressed: _calculateAffordability,
                icon: Icon(Icons.check_circle_outline),
                label: Text(
                  'Check Affordability',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),
            if (_result.isNotEmpty)
              Card(
                color: _result.contains('❌') ? Colors.red[50] : Colors.blue[50],
                elevation: 3,
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
                      color: Color(0xFF1877F2),
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
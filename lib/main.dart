import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final evaluator = ExpressionEvaluator();
          final expression = _expression
              .replaceAll('x', '*')
              .replaceAll('÷', '/');
          final result = evaluator.eval(Expression.parse(expression), {});
          _result = result.toString();
        } catch (e) {
          _result = 'Erro';
        }
      } else {
        _expression += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_expression, style: const TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),
                  Text(_result, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
              ),
              itemCount: buttons.length,
              itemBuilder: (context, index) {
                return TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: buttons[index]['type'] == 'operator'
                        ? Colors.orange
                        : Colors.grey[700],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () => _onButtonPressed(buttons[index]['value']!),
                  child: Text(buttons[index]['value']!, style: const TextStyle(fontSize: 20)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> buttons = [
  {'value': '7', 'type': 'number'},
  {'value': '8', 'type': 'number'},
  {'value': '9', 'type': 'number'},
  {'value': '÷', 'type': 'operator'},
  {'value': '4', 'type': 'number'},
  {'value': '5', 'type': 'number'},
  {'value': '6', 'type': 'number'},
  {'value': 'x', 'type': 'operator'},
  {'value': '1', 'type': 'number'},
  {'value': '2', 'type': 'number'},
  {'value': '3', 'type': 'number'},
  {'value': '-', 'type': 'operator'},
  {'value': 'C', 'type': 'operator'},
  {'value': '0', 'type': 'number'},
  {'value': '=', 'type': 'operator'},
  {'value': '+', 'type': 'operator'},
];
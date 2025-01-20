import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '0';
  String expression = '';

  void _onPressed(String label) {
    setState(() {
      if (label == 'C') {
        display = '0';
        expression = '';
      } else if (label == '%') {
        // Calcula a porcentagem
        if (expression.isNotEmpty) {
          try {
            final value = double.parse(expression);
            display = (value / 100).toString();
            expression = display;
          } catch (e) {
            display = 'Error';
          }
        }
      } else if (label == '=') {
        try {
          final result = _evaluateExpression(expression);
          display = result.toString();
          expression = '';
        } catch (e) {
          display = 'Error';
        }
      } else {
        if (display == '0' && label != '.') {
          display = label;
        } else {
          display += label;
        }
        expression += label;
      }
    });
  }

  double _evaluateExpression(String expression) {
    try {
      final parsedExpression = Expression.parse(expression);
      const evaluator = ExpressionEvaluator();
      final result = evaluator.eval(parsedExpression, {});
      return result is double ? result : (result as int).toDouble();
    } catch (e) {
      throw Exception('Invalid expression');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display da calculadora
        Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16),
            color: Colors.black45,
            child: Text(
              display,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
          ),
        ),
        // Botões da calculadora
        Flexible(
          flex: 8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildButtonRow(['%', '(', ')', '^']),
                _buildButtonRow(['7', '8', '9', '/']),
                _buildButtonRow(['4', '5', '6', '*']),
                _buildButtonRow(['1', '2', '3', '-']),
                _buildButtonRow(['C', '0', '=', '+']),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonRow(List<String> labels) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: labels.map((label) {
          return Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: label == '=' ? Colors.deepOrange : Colors.grey.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Bordas dos botões
                  ),
                ),
                onPressed: () => _onPressed(label),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

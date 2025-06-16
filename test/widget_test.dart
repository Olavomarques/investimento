import 'package:flutter/material.dart';

void main() {
  runApp(const InvestimentoApp());
}

class InvestimentoApp extends StatelessWidget {
  const InvestimentoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Investimentos',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const InvestimentoPage(),
    );
  }
}

class InvestimentoPage extends StatefulWidget {
  const InvestimentoPage({super.key});

  @override
  _InvestimentoPageState createState() => _InvestimentoPageState();
}

class _InvestimentoPageState extends State<InvestimentoPage> {
  final TextEditingController _valorMensalController = TextEditingController();
  final TextEditingController _mesesController = TextEditingController();
  final TextEditingController _jurosController = TextEditingController();
  double _totalSemJuros = 0.0;
  double _totalComJuros = 0.0;

  void _simularInvestimento() {
    final valorMensal = double.tryParse(_valorMensalController.text) ?? 0.0;
    final meses = int.tryParse(_mesesController.text) ?? 0;
    final juros = double.tryParse(_jurosController.text) ?? 0.0;

    // Cálculo do valor total sem juros
    final semJuros = valorMensal * meses;

    // Cálculo do valor total com juros compostos
    double comJuros = 0.0;
    if (juros > 0) {
      final taxa = juros / 100;
      for (int i = 0; i < meses; i++) {
        comJuros = (comJuros + valorMensal) * (1 + taxa);
      }
    } else {
      comJuros = semJuros;
    }

    setState(() {
      _totalSemJuros = semJuros;
      _totalComJuros = comJuros;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulador de Investimentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Investimento mensal:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _valorMensalController,
              decoration: const InputDecoration(
                hintText: 'Digite o valor',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text('Número de meses:'),
            TextField(
              controller: _mesesController,
              decoration: const InputDecoration(
                hintText: 'Quantos meses deseja investir',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            const Text('Taxa de juros ao mês:'),
            TextField(
              controller: _jurosController,
              decoration: const InputDecoration(
                hintText: 'Digite a taxa de juros',
                suffixText: '%',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _simularInvestimento,
                child: const Text('Simular'),
              ),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Valor total sem juros: R\$ ${_totalSemJuros.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Valor total com juros compostos: R\$ ${_totalComJuros.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _valorMensalController.dispose();
    _mesesController.dispose();
    _jurosController.dispose();
    super.dispose();
  }
}
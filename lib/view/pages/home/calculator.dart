import 'package:calculator/controller/providers/calc_provider.dart';
import 'package:calculator/core/size/dynamic_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorApp extends ConsumerWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonList = [
      if (ref.read(calcProvider).length == 1) 'AC' else 'C',
      '⌫',
      '%',
      '÷',
      '7',
      '8',
      '9',
      'x',
      '4',
      '5',
      '6',
      '-',
      '1',
      '2',
      '3',
      '+',
      '00',
      '0',
      '.',
      '=',
    ];

    final calc = ref.watch(calcProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            height: context.height(.25),
            alignment: Alignment.bottomRight,
            child: Text(
              calc,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: buttonList.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    ref
                        .read(calcProvider.notifier)
                        .buttonEvent(str: buttonList[index].toString());
                  },
                  style: ButtonStyle(
                    backgroundColor: buttonList[index] == '='
                        ? const MaterialStatePropertyAll(Colors.orange)
                        : const MaterialStatePropertyAll(Colors.transparent),
                  ),
                  child: Text(
                    buttonList[index].toString(),
                    style: TextStyle(
                      color: index < 4 ||
                              buttonList[index] == 'x' ||
                              buttonList[index] == '-' ||
                              buttonList[index] == '+'
                          ? Colors.amber
                          : const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 26,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
// import 'package:peps/models/result_tab.dart';
// import 'package:peps/widgets/results_item.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    super.key,
    required this.results,
    required this.onRemoveExpense,
  });
  final List<String> results;
  final void Function(List result) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: results.length,
        itemBuilder: (ctx, indx) => Dismissible(
            onDismissed: (direction) {
              onRemoveExpense(results[indx]);
            },
            key: ValueKey(results[indx]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.80),
              margin: Theme.of(context).cardTheme.margin,
            ),
            child: const Text("done")));
  }
}

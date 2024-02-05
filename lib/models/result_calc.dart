import 'package:flutter/material.dart';
// import 'package:peps/models/result_tab.dart';
// import 'package:peps/widgets/result_box.dart';

class ResultCalc extends StatefulWidget {
  ResultCalc({super.key});
  // final ResultTab result;

  // final List<ResultTab> resultsRegistration = [];
  @override
  State<ResultCalc> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultCalc> {
  void removeResult(ResultTab result) {
    final removedIndx = widget.resultsRegistration.indexOf(result);
    setState(() {
      widget.resultsRegistration.remove(result);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                widget.resultsRegistration.insert(removedIndx, result);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void removeResult(ResultTab resultRm) {
      final removedIndx = widget.resultsRegistration.indexOf(resultRm);
      setState(() {
        widget.resultsRegistration.remove(resultRm);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Expense deleted'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  widget.resultsRegistration.insert(removedIndx, resultRm);
                });
              }),
        ),
      );
    }

    return Center(
      child: widget.resultsRegistration.isNotEmpty
          ? ResultBox(
              results: widget.resultsRegistration,
              onRemoveExpense: removeResult,
            )
          : const Center(
              child: Text("No items to show!"),
            ),
    );
  }
}

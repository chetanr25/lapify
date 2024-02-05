import 'package:flutter/material.dart';
// import 'package:peps/models/result_tab.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({super.key});

  // final ResultTab results;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('results.name'
                // style: Theme.of(context).textTheme.titleLarge,
                ),
            const SizedBox(height: 5),
            Row(
              children: [
                // Text('₹${results.price.toString()}'),
                const Spacer(),
                Row(
                  children: [
                    // Text(results.headboard),
                    Text(
                        "${'done'.toString()} x ${'results.breadth'.toString()}"),
                    // Icon(CategoryIcon[expense.category]),
                    const SizedBox(width: 5),
                    // Text(expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

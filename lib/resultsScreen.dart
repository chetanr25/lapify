// ignore: file_names
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';

// ignore: must_be_immutable
class ResultsScreen extends StatefulWidget {
  String manufacturer;
  String screenSize;
  String ram;
  // ignore: prefer_typing_uninitialized_variables
  var excel;
  late List<List<Data?>> _result;
  ResultsScreen(
      {super.key,
      required this.manufacturer,
      required this.screenSize,
      required this.ram,
      required this.excel});
//  @override
  // _ResultsScreenState createState() => _ResultsScreenState();

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchResults();
  }

  Future<List<List<Data?>>> _fetchResults() async {
    Sheet sheet = widget.excel.tables['laptops']!;
    var firstRow = sheet.rows.first.map((e) => e!.value.toString()).toList();
    int manufacturerColumnIndex = firstRow.indexOf('Manufacturer');
    int screenSizeColumnIndex = firstRow.indexOf('Screen Size');
    int ramColumnIndex = firstRow.indexOf('RAM');
    widget._result = sheet.rows.where((row) {
      return row[manufacturerColumnIndex]!.value.toString() ==
              widget.manufacturer &&
          row[screenSizeColumnIndex]!.value.toString() ==
              ('${widget.screenSize} inch') &&
          row[ramColumnIndex]!.value.toString() == ('${widget.ram}GB');
    }).toList();
    return widget._result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Results'),
        ),
        body: FutureBuilder<List<List<Data?>>>(
          future: Future.value(widget._result),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: Text(
                "No results found",
                style: TextStyle(fontSize: 24),
              ));
            } else if (snapshot.hasError) {
              return Center(
                child: Center(
                    child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(fontSize: 24),
                )),
              );
            } else if (widget._result.isEmpty) {
              return const Center(
                  child: Text(
                "No results found",
                style: TextStyle(fontSize: 24),
              ));
            } else {
              return ListView.builder(
                dragStartBehavior: DragStartBehavior.down,
                itemCount: widget._result.length,
                itemBuilder: (context, index) {
                  if (widget._result.length <= 1) {
                    return const Center(child: Text("No results found"));
                  }
                  return Column(
                    children: ListTile.divideTiles(
                      context: context,
                      // color: Color(0xff000000),
                      tiles: [
                        ListTile(
                          // dense: true,
                          // focusColor: Colors.black,
                          leading: Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(177, 0, 0, 0),
                              fontSize: 24,
                            ),
                          ),
                          title: Text(
                              '${widget._result[index][0]!.value} ${widget._result[index][1]!.value}'),
                          subtitle: Text(
                              '${widget._result[index][5]!.value}\n${widget._result[index][7]!.value}\n${widget._result[index][8]!.value}'),
                          trailing: Text(
                            'Rs. ${widget._result[index][12]!.value.toString().replaceAll(',', '')}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ).toList(),
                  );
                },
              );
            }
          },
        ));
  }
}

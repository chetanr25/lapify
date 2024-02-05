// import 'package:flutter/material.dart';

// class ResultsScreen extends StatefulWidget {
//   const ResultsScreen({super.key});

//   @override
//   State<ResultsScreen> createState() => _ResultsScreenState();
// }

// class _ResultsScreenState extends State<ResultsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
// import 'package:flutter/services.dart' show ByteData, rootBundle;

// import 'package:flutter_excel/flutter_excel.dart';

class ResultsScreen extends StatefulWidget {
  String manufacturer;
  String screenSize;
  String ram;
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
  // Future<List<List<Data?>>>? _results = null;

  @override
  void initState() {
    super.initState();
    _fetchResults();
  }
  // Future<void> loadExcel() async {
  //   ByteData data = await rootBundle.load("assets/laptopData.xlsx");
  //   var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  //   excel = Excel.decodeBytes(bytes);
  // }

  Future<List<List<Data?>>> _fetchResults() async {
    // Assuming the excel file is in the assets folder
    // String filePath = 'assets/laptops.xlsx';
    // ByteData data = await rootBundle.load("assets/laptopData.xlsx");
    // late var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // late var excel = Excel.decodeBytes(bytes);
    Sheet sheet = widget.excel.tables['laptops']!;

    // Find the column indices of the specified headers
    var firstRow = sheet.rows.first.map((e) => e!.value.toString()).toList();
    int manufacturerColumnIndex = firstRow.indexOf('Manufacturer');
    int screenSizeColumnIndex = firstRow.indexOf('Screen Size');
    int ramColumnIndex = firstRow.indexOf('RAM');
    // print(firstRow);
    // print(manufacturerColumnIndex);
    // print(screenSizeColumnIndex);
    // print(ramColumnIndex);

    // print(widget.manufacturer);
    // // print(widget._result);
    // print(widget.ram);
    // print(widget.screenSize);

    // await Future.delayed(const Duration(seconds: 2));
    // Filter the data based on the specified criteria
    widget._result = sheet.rows.where((row) {
      // print(row[screenSizeColumnIndex]!.value!.toString() +
      //     ' ' +
      //     (widget.screenSize + ' inch'));
      // print(row[ramColumnIndex]!.value.toString() + ' ' + (widget.ram + 'GB'));
      return row[manufacturerColumnIndex]!.value.toString() ==
              widget.manufacturer &&
          row[screenSizeColumnIndex]!.value.toString() ==
              (widget.screenSize + ' inch') &&
          row[ramColumnIndex]!.value.toString() == (widget.ram + 'GB');
    }).toList();
    // print(widget._result);
    return widget._result;
    await Future.delayed(const Duration(seconds: 2));
    // print(widget._results);
    // return _results;
    // _results = sheet.where((row) {
    //   return row[manufacturerColumnIndex] == widget.manufacturer &&
    //       row[screenSizeColumnIndex] == widget.screenSize &&
    //       row[ramColumnIndex] == widget.ram;
    // }).toList();

    setState(() {});
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
              print('waiting?');
              return const Center(
                  child: Text(
                "No results found",
                style: TextStyle(fontSize: 24),
              ));
            } else if (snapshot.hasError) {
              print('error');
              return Center(
                child: Center(
                    child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 24),
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
                  print(widget._result.length);
                  if (widget._result.length <= 1) {
                    return const Center(child: Text("No results found"));
                  }
                  // return ListView.builder(
                  //   itemCount: widget._result.length,
                  //   itemBuilder: (ctx, indx) => Dismissible(
                  //     onDismissed: (direction) {},
                  //     key: UniqueKey(),
                  //     background: Container(
                  //       color: Theme.of(context)
                  //           .colorScheme
                  //           .error
                  //           .withOpacity(0.80),
                  //       margin: Theme.of(context).cardTheme.margin,
                  //     ),
                  //     child: Text(widget._result[index][0]!.value.toString()),
                  //   ),
                  //   // title: Text(widget._result[index][0]!.value.toString()),
                  //   // subtitle:
                  //   //     Text(widget._result[index][1]!.value.toString()),
                  //   // widget._result[index][0]!.value.toString(),
                  // );
                  return Column(
                    children: ListTile.divideTiles(
                      context: context,
                      // color: Color(0xff000000),
                      tiles: [
                        Container(
                          // foregroundDecoration: BoxDecoration(
                          //   color: const Color.fromARGB(177, 0, 0, 0),
                          // ),
                          child: ListTile(
                            // dense: true,
                            // focusColor: Colors.black,
                            leading: Container(
                              // decoration: BoxDecoration(
                              //     color: const Color.fromARGB(177, 0, 0, 0)),
                              child: Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                  color: Color.fromARGB(177, 0, 0, 0),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            title: Text(
                                widget._result[index][0]!.value.toString() +
                                    ' ' +
                                    widget._result[index][1]!.value.toString()),
                            subtitle: Text(
                                widget._result[index][5]!.value.toString() +
                                    '\n' +
                                    widget._result[index][7]!.value.toString() +
                                    '\n' +
                                    widget._result[index][8]!.value.toString()),
                            trailing: Text(
                              'Rs. ' +
                                  widget._result[index][12]!.value
                                      .toString()
                                      .replaceAll(',', ''),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ).toList(),
                  );
                },
              );
            }
          },
        )
        // : const Center(child: CircularProgressIndicator()),
        // body: widget._results != null
        //     ? ListView.builder(
        //         itemCount: widget._results!.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             title: Text(_results[index][0]),
        //             subtitle: Text(_results[index][1]),
        //           );
        //         },
        //       )
        //     : const Center(child: CircularProgressIndicator()),
        );
  }
}

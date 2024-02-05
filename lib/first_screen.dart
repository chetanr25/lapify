import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:mini/resultsScreen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late var excel;
  Future<void> loadExcel() async {
    ByteData data = await rootBundle.load("assets/laptopData.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    excel = Excel.decodeBytes(bytes);
  }

  String? selectedmanufacture;
  String? selectedscreen;
  String? selectedram;

  var dropdownEntriesmanufacture = <DropdownMenuItem<dynamic>>[];
  var dropdownEntriesscreen = <DropdownMenuItem<dynamic>>[];
  var dropdownEntriesram = <DropdownMenuItem<dynamic>>[];

  var manufacture = [
    'Select brand',
    'Acer',
    'Apple',
    'Asus',
    'Chuwi',
    'Dell',
    'Google',
    'HP',
    'Huawei',
    'Microsoft',
    'Samsung'
  ];
  var screen = ['Select Screen Size', '14', '16', '17'];
  var ram = ['Select RAM', '8', '16', '32', '64'];
  @override
  void initState() {
    super.initState();
    loadExcel();
    selectedmanufacture = "Select brand";
    selectedscreen = "Select Screen Size";
    selectedram = "Select RAM";
    // selectedHeadboard = 'Select Base Headboard';

    // selectedBreadth = "Select model";
    dropdownEntriesmanufacture = convertListToDropdownEntries(
        manufacture, dropdownEntriesmanufacture, '');
    dropdownEntriesscreen =
        convertListToDropdownEntries(screen, dropdownEntriesscreen, ' inch');
    dropdownEntriesram =
        convertListToDropdownEntries(ram, dropdownEntriesram, ' GB');
    // dropdownHeadboard =
    //     convertListToDropdownEntries(headboard, dropdownHeadboard);
  }

  dynamic convertListToDropdownEntries(List<dynamic> list, drop, s) {
    drop = list.map<DropdownMenuItem<dynamic>>((item) {
      return DropdownMenuItem<dynamic>(
        value: item.toString(),
        child: Text(item.toString() + s),
      );
    }).toList();
    return drop;
  }

  // String? selectedHeadboard;

  //   var dropdownEntriesMa = <DropdownMenuItem<dynamic>>[];
  // var dropdownEntriesLength = <DropdownMenuItem<dynamic>>[];
  // var dropdownEntriesBreadth = <DropdownMenuItem<dynamic>>[];

  // var dropdownHeadboard = <DropdownMenuItem<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laptify', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,

                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/laptopImage.png'),
                    // fit: BoxFit.cover,
                  ),
                ),
                // rest of the code
              ),
              Container(
                child: const Text(
                  'Welcome to Lapify',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      // color: Colors.blue,
                      fontFamily: 'Roboto'),
                ),
              ),
              const Text('Helping you find the perfect laptop for you!',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    // color: Colors.blue,
                    // fontFamily: 'Roboto',
                  )),
              const Gap(20),
              Container(
                // alignment: Alignment.center,
                // padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  // padding: const EdgeInsets.all(20),
                  // color: const Color.fromARGB(26, 33, 198, 243),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(29, 33, 149, 243),
                      blurRadius: 0,
                      offset: Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  // controller: controller,
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    widthFactor: double.infinity,
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,

                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DropdownButton(
                          onChanged: (value) {
                            if (value == 'Select brand' || value == null) {
                              return;
                            }
                            setState(() {
                              selectedmanufacture = value!;
                              // updateHeadboard(value);
                            });
                          },
                          value: selectedmanufacture,
                          items: dropdownEntriesmanufacture,
                          isExpanded: true,
                        ),
                        const Gap(10),
                        DropdownButton(
                          onChanged: (value) {
                            if (value == 'Select screen') {
                              const SnackBar(
                                content:
                                    Text("Please select from the dropdown"),
                              );

                              return;
                            }
                            setState(() {
                              selectedscreen = value!;
                            });
                          },
                          value: selectedscreen,
                          items: dropdownEntriesscreen,
                          isExpanded: true,
                        ),
                        const Gap(10),
                        DropdownButton(
                          onChanged: (value) {
                            // ignore: curly_braces_in_flow_control_structures
                            if (value == 'Select ram') if (value ==
                                'Select Base Headboard') {
                              return;
                            }
                            setState(() {
                              selectedram = value!;
                            });
                          },
                          value: selectedram,
                          items: dropdownEntriesram,
                          isExpanded: true,
                        ),
                        const Gap(10),
                        // DropdownButton(
                        //   onChanged: (value) {
                        //     if (value == 'Select Base Headboard') {
                        //       return;
                        //     }
                        //     setState(() {
                        //       selectedHeadboard = value!;
                        //     });
                        //   },
                        //   value: selectedHeadboard,
                        //   items: dropdownHeadboard,
                        //   isExpanded: true,
                        // ),
                        const Gap(10),

                        ElevatedButton(
                          onPressed: () async {
                            if (selectedmanufacture == "Select brand" ||
                                selectedscreen == "Select screen" ||
                                selectedram == "Select ram") {
                              const SnackBar(
                                content:
                                    Text("Please select from the dropdown"),
                              );
                              return;
                            }

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultsScreen(
                                  manufacturer: selectedmanufacture!,
                                  screenSize: selectedscreen!,
                                  ram: selectedram!,
                                  excel: excel,
                                ),
                              ),
                            );
                            // if (selectedmanufacture == "Select model" ||
                            //     selectedscreen == "Select screen" ||
                            //     selectedram == "Select ram" ||
                            //     selectedHeadboard == "Select Base Headboard") {
                            //   return;
                            // }

                            // var inputResult = ResultTab(
                            //   ram: selectedram!,
                            //   headboard: selectedHeadboard!,
                            //   screen: int.parse(selectedscreen!),
                            //   model: selectedmanufacture!,
                            //   price: getPrice(),
                            // );
                            // headboard = ['Select Base Headboard'];
                            // dropdownHeadboard = convertListToDropdownEntries(
                            //     headboard, dropdownHeadboard);
                            // setState(() {
                            //   ResultCalc(
                            //     result: inputResult,
                            //   );
                            // });
                            // // getPrice();
                            // displayResults(getPrice());
                          },
                          child: const Text('Search'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

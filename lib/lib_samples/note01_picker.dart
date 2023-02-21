import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_picker/flutter_picker.dart';
import '../util/Log.dart';
import 'picker_test.dart';
import 'PickerData.dart';
void main() {
  runApp(const MaterialApp(
    title: "MaterialApp",
    home: PickerSamplePage(),
  ));
}

class PickerSamplePage extends StatefulWidget {
  const PickerSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}


final String _fontFamily = Platform.isWindows ? "Roboto" : "";


class _MyAppState extends State {
  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final double listSpec = 4.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String stateText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Picker ${stateText.isEmpty ? "" : " - $stateText"}'),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (v) => const RawPickerTest())),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Builder(builder: (context){
        return Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.topCenter,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('1. Picker Show'),
                onTap: () {
                  showPicker(context);
                },
              ),
              ListTile(
                title: const Text('2. Picker Show Modal'),
                onTap: () {
                  showPickerModal(context);
                },
              ),
              ListTile(
                title: const Text('3. Picker Show Icons'),
                onTap: () {
                  showPickerIcons(context);
                },
              ),
              ListTile(
                title: const Text('4. Picker Show (Array)'),
                onTap: () {
                  showPickerArray(context);
                },
              ),
              ListTile(
                title: const Text('5. Picker Show Number'),
                onTap: () {
                  showPickerNumber(context);
                },
              ),
              ListTile(
                title: const Text('6. Picker Show Number FormatValue'),
                onTap: () {
                  showPickerNumberFormatValue(context);
                },
              ),
              ListTile(
                title: const Text('7. Picker Show Date'),
                onTap: () {
                  showPickerDate(context);
                },
              ),
              ListTile(
                title: const Text('8. Picker Show Datetime'),
                onTap: () {
                  showPickerDateTime(context);
                },
              ),
              ListTile(
                title: const Text('9. Picker Show Date (Custom)'),
                onTap: () {
                  showPickerDateCustom(context);
                },
              ),
              ListTile(
                title: const Text('10. Picker Show Datetime (24)'),
                onTap: () {
                  showPickerDateTime24(context);
                },
              ),
              ListTile(
                title: const Text('11. Picker Show Datetime (Round background)'),
                onTap: () {
                  showPickerDateTimeRoundBg(context);
                },
              ),
              ListTile(
                title: const Text('12. Picker Show Date Range'),
                onTap: () {
                  showPickerDateRange(context);
                },
              ),
              ListTile(
                title: const Text('13. DurationPicker (time)'),
                onTap: () {
                  showPickerDurationSelect(context);
                },
              ),
              ListTile(
                title: const Text('14. Customize UI effects (time)'),
                onTap: () {
                  showPickerCustomizeUI(context);
                },
              ),
              ListTile(
                title: const Text('15. Use onBuilderItem'),
                onTap: () {
                  showPickerCustomBuilder(context);
                },
              ),
            ],
          ),
        );
      },),
    );
  }

  showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  showPicker(BuildContext context) async {
    Picker picker = Picker(
        adapter: PickerDataAdapter<String>(
            pickerData: const JsonDecoder().convert(PickerData)),
        changeToFirst: false,
        textAlign: TextAlign.left,
        textStyle: TextStyle(color: Colors.blue, fontFamily: _fontFamily),
        selectedTextStyle: const TextStyle(color: Colors.red),
        columnPadding: const EdgeInsets.all(8.0),
        onConfirm: (Picker picker, List value) {
          Log.d(value.toString());
          Log.d(picker.getSelectedValues());
        });
    picker.showBottomSheet(context);
  }

  showPickerModal(BuildContext context) async {
    final result = await Picker(
        adapter: PickerDataAdapter<String>(
            pickerData: const JsonDecoder().convert(PickerData)),
        changeToFirst: true,
        hideHeader: false,
        selectedTextStyle: const TextStyle(color: Colors.blue),
        // builderHeader: (context) {
        //   final picker = PickerWidget.of(context);
        //   return picker?.data?.title ?? Text("xxx");
        // },
        onConfirm: (picker, value) {
          Log.d(value.toString());
          Log.d(picker.adapter.text);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: const Text("Hello")),
                    body: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("You click the Confirm button."),
                            const SizedBox(height: 32),
                            Text("result: \n ${picker.adapter.text}")
                          ],
                        )),
                  )));
        }).showModal(this.context); //_sca
    Log.d("result: $result"); // ffoldKey.currentState);
  }

  showPickerIcons(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(data: [
        PickerItem(text: const Icon(Icons.add), value: Icons.add, children: [
          PickerItem(text: const Icon(Icons.more)),
          PickerItem(text: const Icon(Icons.aspect_ratio)),
          PickerItem(text: const Icon(Icons.android)),
          PickerItem(text: const Icon(Icons.menu), children: [
            // 测试：多加了一维数据
            PickerItem(text: const Icon(Icons.account_box)),
            PickerItem(text: const Icon(Icons.analytics)),
          ]),
        ]),
        PickerItem(text: const Icon(Icons.title), value: Icons.title, children: [
          PickerItem(text: const Icon(Icons.more_vert)),
          PickerItem(text: const Icon(Icons.ac_unit)),
          PickerItem(text: const Icon(Icons.access_alarm)),
          PickerItem(text: const Icon(Icons.account_balance)),
        ]),
        PickerItem(text: const Icon(Icons.face), value: Icons.face, children: [
          PickerItem(text: const Icon(Icons.add_circle_outline)),
          PickerItem(text: const Icon(Icons.add_a_photo)),
          PickerItem(text: const Icon(Icons.access_time)),
          PickerItem(text: const Icon(Icons.adjust)),
        ]),
        PickerItem(
            text: const Icon(Icons.linear_scale),
            value: Icons.linear_scale,
            children: [
              PickerItem(text: const Icon(Icons.assistant_photo)),
              PickerItem(text: const Icon(Icons.account_balance)),
              PickerItem(text: const Icon(Icons.airline_seat_legroom_extra)),
              PickerItem(text: const Icon(Icons.airport_shuttle)),
              PickerItem(text: const Icon(Icons.settings_bluetooth)),
            ]),
        PickerItem(text: const Icon(Icons.close), value: Icons.close),
      ]),
      title: const Text("Select Icon"),
      selectedTextStyle: const TextStyle(color: Colors.blue, fontSize: 12),
      onConfirm: (Picker picker, List value) {
        Log.d(value.toString());
        Log.d(picker.getSelectedValues());
      },
    ).showBottomSheet(context);
  }

  showPickerDialog(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
            pickerData: const JsonDecoder().convert(PickerData)),
        hideHeader: true,
        title: const Text("Select Data"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          Log.d(value.toString());
          Log.d(picker.getSelectedValues());
        }).showDialog(context);
  }

  showPickerArray(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter<String>(
          pickerData: const JsonDecoder().convert(PickerData2),
          isArray: true,
        ),
        hideHeader: true,
        selecteds: [3, 0, 2],
        title: const Text("Please Select"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        cancel: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.child_care)),
        onConfirm: (Picker picker, List value) {
          Log.d(value.toString());
          Log.d(picker.getSelectedValues());
        }).showDialog(context);
  }

  showPickerNumber(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          const NumberPickerColumn(
              begin: 0,
              end: 999,
              postfix: Text("\$"),
              suffix: Icon(Icons.insert_emoticon)),
          const NumberPickerColumn(begin: 200, end: 100, jump: -10),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
                width: 30.0,
                alignment: Alignment.center,
                child: const Icon(Icons.more_vert),
              ))
        ],
        hideHeader: true,
        title: const Text("Please Select"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          Log.d(value.toString());
          Log.d(picker.getSelectedValues());
        }).showDialog(context);
  }

  showPickerNumberFormatValue(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
              begin: 0,
              end: 999,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }),
          const NumberPickerColumn(begin: 100, end: 200),
        ]),
        delimiter: [
          PickerDelimiter(
              child: Container(
                width: 30.0,
                alignment: Alignment.center,
                child: const Icon(Icons.more_vert),
              ))
        ],
        hideHeader: true,
        title: const Text("Please Select"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          Log.d(value.toString());
          Log.d(picker.getSelectedValues());
        }).showDialog(context);
  }

  showPickerDate(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(),
        title: const Text("Select Data"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          Log.d((picker.adapter as DateTimePickerAdapter).value);
        }).showDialog(context);
  }

  showPickerDateCustom(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          customColumnType: [2, 1, 0, 3, 4],
        ),
        title: const Text("Select Data"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          Log.d((picker.adapter as DateTimePickerAdapter).value);
        }).showDialog(context);
  }

  showPickerDateTime(BuildContext context) {
    Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kMDYHM_AP,
          isNumberMonth: true,
          //strAMPM: const["上午", "下午"],
          yearSuffix: "年",
          monthSuffix: "月",
          daySuffix: "日",
          hourSuffix: "時",
          minuteSuffix: "分",
          secondSuffix: "秒",
          minValue: DateTime.now(),
          minuteInterval: 30,
          //minHour: 1,
          //maxHour: 23,
          // twoDigitYear: true,
        ),
        title: const Text("Select DateTime"),
        textAlign: TextAlign.right,
        selectedTextStyle: const TextStyle(color: Colors.blue),
        delimiter: [
          PickerDelimiter(
              column: 5,
              child: Container(
                width: 16.0,
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
              ))
        ],
        footer: Container(
          height: 50.0,
          alignment: Alignment.center,
          child: const Text('Footer'),
        ),
        onConfirm: (Picker picker, List value) {
          Log.d(picker.adapter.text);
        },
        onSelect: (Picker picker, int index, List<int> selected) {
          setState(() {
            stateText = picker.adapter.toString();
          });
        }).showBottomSheet(context);
  }

  showPickerDateRange(BuildContext context) {
    Log.d("canceltext: ${PickerLocalizations.of(context).cancelText}");

    Picker ps = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: true),
        onConfirm: (Picker picker, List value) {
          Log.d((picker.adapter as DateTimePickerAdapter).value);
        });

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          Log.d((picker.adapter as DateTimePickerAdapter).value);
        });

    List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(PickerLocalizations.of(context).cancelText ?? '')),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm?.call(ps, ps.selecteds);
            pe.onConfirm?.call(pe, pe.selecteds);
          },
          child: Text(PickerLocalizations.of(context).confirmText ?? ''))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Select Date Range"),
            actions: actions,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text("Begin:"),
                ps.makePicker(),
                const Text("End:"),
                pe.makePicker()
              ],
            ),
          );
        });
  }

  showPickerDateTime24(BuildContext context) {
    Picker(
        adapter: DateTimePickerAdapter(
          type: PickerDateTimeType.kMDYHM,
          isNumberMonth: true,
          yearSuffix: "年",
          monthSuffix: "月",
          daySuffix: "日",
          hourSuffix: "時",
          minuteSuffix: "分",
          secondSuffix: "秒",
          minHour: 8,
          maxHour: 19,
          yearBegin: 1950,
          yearEnd: 1998,
        ),
        title: const Text("Select DateTime"),
        onConfirm: (Picker picker, List value) {
          Log.d(picker.adapter.text);
        },
        onSelect: (Picker picker, int index, List<int> selected) {
          showMsg(picker.adapter.toString());
        }).showBottomSheet(context);
  }

  /// 圆角背景
  showPickerDateTimeRoundBg(BuildContext context) {
    var picker = Picker(
        backgroundColor: Colors.transparent,
        headerDecoration: const BoxDecoration(
            border:
            Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kMDYHM,
            isNumberMonth: true,
            yearSuffix: "年",
            monthSuffix: "月",
            daySuffix: "日"),
        delimiter: [
          PickerDelimiter(
              column: 3,
              child: Container(
                width: 8.0,
                alignment: Alignment.center,
              )),
          PickerDelimiter(
              column: 5,
              child: Container(
                width: 12.0,
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(':', style: TextStyle(fontWeight: FontWeight.bold)),
              )),
        ],
        title: const Text("Select DateTime"),
        onConfirm: (Picker picker, List value) {
          Log.d(picker.adapter.text);
        },
        onSelect: (Picker picker, int index, List<int> selected) {
          showMsg(picker.adapter.toString());
        });
    picker.showModal(context, backgroundColor: Colors.transparent,
        builder: (context, view) {
          return Material(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Container(
                padding: const EdgeInsets.only(top: 4),
                child: view,
              ));
        });
  }

  /// 使用 onBuilderItem 方法
  showPickerCustomBuilder(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          customColumnType: [2, 1, 0, 3, 4],
        ),
        title: const Text("Select Data"),
        selectedTextStyle: const TextStyle(color: Colors.blue),
        onBuilderItem: (context, text, child, selected, col, index) {
          if (col == 0 || selected) return null;
          return Text(text ?? '',
              style: const TextStyle(
                color: Colors.green,
              ));
        },
        onConfirm: (Picker picker, List value) {
          Log.d((picker.adapter as DateTimePickerAdapter).value);
        }).showDialog(context);
  }

  /// 自定义UI效果
  showPickerCustomizeUI(BuildContext context) {
    const itemExtent = 42.0;
    final bgColor = Colors.greenAccent.shade700;
    const txtColor = Colors.white;
    const txtStyle = TextStyle(color: txtColor);
    final selectColor = Colors.black.withOpacity(0.20);
    final delimiterChild = Align(
      alignment: Alignment.center,
      child: Container(width: 50, height: itemExtent, color: selectColor),
    );
    Picker(
        itemExtent: itemExtent,
        backgroundColor: Colors.transparent,
        containerColor: bgColor,
        selectionOverlay: Container(height: itemExtent, color: selectColor),
        headerDecoration: BoxDecoration(color: Colors.black.withOpacity(0.05)),
        textStyle: txtStyle,
        cancelTextStyle: txtStyle,
        confirmTextStyle: txtStyle,
        selectedTextStyle: const TextStyle(color: txtColor, fontSize: 20),
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kHM),
        delimiter: [
          PickerDelimiter(column: 0, child: delimiterChild),
          PickerDelimiter(
              column: 2,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 15,
                  height: itemExtent,
                  color: selectColor,
                  alignment: Alignment.center,
                  child: const Text(':',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: txtColor)),
                ),
              )),
          PickerDelimiter(column: 4, child: delimiterChild),
        ],
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
          child: Text("Select Time", style: txtStyle),
        ),
        onConfirm: (Picker picker, List value) {
          Log.d(picker.adapter.text);
        }).showModal(context, builder: (context, view) {
      return Material(
          elevation: 0.0,
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: view,
          ));
    }, backgroundColor: Colors.transparent);
  }

  showPickerDurationSelect(BuildContext context) {
    final range = <DateTime?>[
      DateTime(0, 1, 1, 8, 30),
      DateTime(0, 1, 1, 14, 30)
    ];
    final p1 = Picker(
        adapter: DateTimePickerAdapter(
          customColumnType: [6, 7, 4],
          value: range[0],
        ),
        delimiter: [
          PickerDelimiter(
              column: 0,
              child: Container(
                alignment: Alignment.center,
                width: 100,
                padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                color: Colors.white,
                child: const Text('Start',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14)),
              )),
        ],
        onSelect: (Picker picker, int index, List<int> selected) {
          range[0] = (picker.adapter as DateTimePickerAdapter).value;
        },
        onConfirmBefore: (picker, selected) async {
          if (range[0] == null) {
            showMsg("Please select the start time.");
            return false;
          }
          if (range[1] == null) {
            showMsg("Please select the end time.");
            return false;
          }
          return true;
        },
        onConfirm: (picker, selected) {
          showMsg(
              "Start: ${range[0].toString()}, End: ${range[1].toString()}, ${picker.adapter}");
        });
    final p2 = Picker(
        adapter: DateTimePickerAdapter(
          customColumnType: [6, 7, 4],
          value: range[1],
        ),
        hideHeader: true,
        delimiter: [
          PickerDelimiter(
              column: 0,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
                width: 100,
                color: Colors.white,
                child: const Text('End',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14)),
              )),
        ],
        onSelect: (Picker picker, int index, List<int> selected) {
          range[1] = (picker.adapter as DateTimePickerAdapter).value;
        });
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [p1.makePicker(), p2.makePicker()],
          );
        });
  }
}

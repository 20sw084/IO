import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MaterialApp(
    title: 'IO',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IO'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: const InputDecoration(labelText: 'Write Something'),
          ),
          subtitle: ElevatedButton(
            onPressed: () {
              setState(() {
                writeD(_enterDataField.text);
              });
            },
            child: Column(
              children: <Widget>[
                const Text('Save Data'),
                const Padding(padding: EdgeInsets.all(14.5)),
                FutureBuilder(
                  future: readD(),
                  builder: (BuildContext context, AsyncSnapshot<String> data) {
                    if (data.hasData != null) {
                      // NOT
                      return Text(
                        data.data.toString(),
                        style: const TextStyle(color: Colors.white70),
                      );
                    } else {
                      return const Text('No Data Saved');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<File> writeD(String counter) async {
    final file = await _localFile;
    // file.writeAsString('$counter');
    // Write the file
    return file.writeAsString('$counter');
  }

  Future<String> readD() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }
}


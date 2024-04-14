import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'menupage.dart';

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "g-sheets-396102",
  "private_key_id": "b85c2004c976a83047b6387f0ba95232172405f4",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDH19sQqz56xQ+g\n0uILcO3ZlvvR34ShL9UXWCBk3SgDUnXZ5j3r9JjJVR2Or1gwc5H6Ksi8sDkjLjjT\n2+etp67aAbXiCqWPUo7splxuH8nuzVZ/WlzGu3ztN4nB7xopNfhqqsB7DnIMk2s8\n6peYytIw4KC/Cw3muC6HV2YNqZW/ipQxgntWDZD2LhzwRzHojszEioOOkRpVD7+0\nwNQvbhz7A0SuKxDaeOyFAxZTZLdTce2N7wb4y6+MPBGeXhAEJvDaiRk3AswOmd9E\nr6WQ/nI/zp54Kn9kiy5jNicGfUWLIjTQIx4X0N7y3+Y7wFzE+ujB08v/r5Tgujhv\n3b3WXq83AgMBAAECggEADr0nTXvrwD8/b1OOU1yxVh5yFSEAlajC9RVNUlMTS+dt\nhLQb9gaUrCioZOkevngPmJ1GL9BpbmRO0aVC2YZn+XEt2m2Bl2f13ZNJdt/GU2P2\nkK7377pNNOunL9P0IHz4BNnyF0FR/QZ0XspIgv7WcL9oa56jmFQWLmouPyy2PCmZ\ndURICWZAh7qmcstTWMgECq7lz0qqz63lv9IcgXSze4C/KC2RXeeiym/PbDqXd6sC\nWp6Eg5k8in39WQbIdA8iKam/43Dp2elm7KNUvVfqF9STqkWtP9bX6EOZ/D5obqNU\n/Frd5T9dwC1sqivSZUSs+cnwT1VQIxVLHj/gxQ0UTQKBgQDlrPEwZtRGILEc3gwL\nh5mgqkYRj9zRHeEuVFcqf9rEdlFxOqb+bI04zIKV9gyT6fbKpoxz1Lbt5Yj3+d1l\nsIrKEnn7TUaCUGTX2XoFzlIYfSEmYa1btUdw1cLEJElInMrHtA0YZKXQZHjMsx0w\nuuFpviZnNaETjpANaYIW8hJ8WwKBgQDev5U48ZeEuWhw4wahArCKa59v8iBn6ohK\nynrb1sH7y2pel0EmZexM/mifSxj3/pn8jSRITA4uerz1u3teurL+Wr8jke6kG7pE\nkDDqseAnCOYCEPZmDBrkctzMGqsDvAMTMaZqHOw99NoKEDLb5o6jj6o17bHYxP5i\nBn2ZwrM/VQKBgQCQE+VZj6gqNeflTAYSVYYyG57I9Y54QF46Sf5EUuBRzkdY2IpZ\noI8WynRAzpElWOfQSJpjL1Vx90PtC3mviQgHq3+J/ff1V6lrHqpFaiBl7FkXUr8F\ngLrINdBwarLuMi2jCXgNjVXXXK/K+bGeGB2/z+EXbbUWJ6CGSWGqM0EVcQKBgCz0\nx749bFI6RWz7NPxMGatmO0CRwp6WhDlsEk3KU05paKd8qYaBbabAdgcoVfq/ZP7G\n0brRts8EsJx74VNmJPgXAprAOkTe38I0w9qqWc4nCp0CJWjFKqxOzmdXPoq7aHd4\nPtkNy1RZ1aPQTyN4rfMu7LCDr7BLWfgYzUK6PAkdAoGBANYl1s5XgaU2IPAC3aWS\nd6rdUH+zPr3mGIDp7F+d5uBss7EuBGfAfFRSqwygYyAIA7lVKNJzqJzo2taWruET\nNz2N7tuSch8LWdGxpdTSAuQZSSR8D+UqCaG/aRhaeGYb4iFCX8wEjqNGtiiTAHm5\ntskZSvB5u4qzlmsJzUu0zSRl\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets-for-flutter@g-sheets-396102.iam.gserviceaccount.com",
  "client_id": "117093724926493305968",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets-for-flutter%40g-sheets-396102.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

final _textController = TextEditingController();

String spreadsheetId = '';

List<Map<String, dynamic>> studentsData = [];

List<String> S_names = [];
List<String> S_rno = [];
List<String> S_marks = [];

// SQLHelper database = new SQLHelper()

//'17c40SkDLmcAGYRCd-ZK6zYObNVaMPvjKZYBEcHLAbig'

void sheetCall() async {
  final gsheets = GSheets(_credentials);

  final ss = await gsheets.spreadsheet(spreadsheetId);

  var sheet = ss.worksheetByTitle('Sheet1');
  // int rows = sheet!.rowCount;

  var cellRows;

  List<String> names = [];

  List<String> marks = [];

  List<String> rollNo = [];

  for (var i = 2; i < 16; i++) {
    cellRows = await sheet?.cells.row(i);
    names.add(cellRows.elementAt(0).value);
    marks.add(cellRows.elementAt(1).value);
    rollNo.add(cellRows.elementAt(2).value);
  }

  S_rno = rollNo;
  S_names = names;
  S_marks = marks;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sheet App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                    hintText: 'Enter your sheet input here',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _textController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    )),
              ),
              const SizedBox(
                height: 10.0,
                width: 10.0,
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    userInput = _textController.text;
                    spreadsheetId = _textController.text;
                    sheetCall();
                  });
                },
                color: Colors.blue,
                child: const Text(
                  'Read File',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Expanded(
                child: Center(
                  child: Text("Your file id is successfully written"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Menu_Page();
                      },
                    ),
                  );
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

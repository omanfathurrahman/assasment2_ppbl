import 'package:assasment2_ppbl/models/tukang_ojek.dart';
import 'package:flutter/material.dart';
import 'sqlite_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saham',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tukang Ojek'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      await addSaham();
      setState(() {});
    });
  }

  Future<int> addSaham() async {
    List<TukangOjek> listOfUsers = [
      TukangOjek(nama: "Asep", nopol: "1234"),
    ];

    return await handler.insertSaham(listOfUsers);
  }

  void loadUlang() {
    print('tes');
    setState(() {});
  }

  bool cekChange(String change) {
    change = change.replaceAll(",", ".");
    double changeDouble = double.parse(change);

    if (changeDouble > 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: handler.retrieveSaham(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TukangOjek>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data![index].id!),
                  child: Card(
                    child: ListTile(
                        onTap: () => {},
                        contentPadding: const EdgeInsets.all(8.0),
                        title: Text(snapshot.data![index].nama),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Text("Nomor Polisi: "),
                                Text(snapshot.data![index].nopol),
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => {TambahSaham(onPressed: loadUlang)}),
          // );
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}

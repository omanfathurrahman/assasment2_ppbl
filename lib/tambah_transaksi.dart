import 'package:assasment2_ppbl/models/tukang_ojek.dart';
import 'package:assasment2_ppbl/sqlite_service.dart';
import 'package:flutter/material.dart';

class TambahTransaksi extends StatefulWidget {
  const TambahTransaksi({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  State<TambahTransaksi> createState() => _TambahTransaksiState();
}

class _TambahTransaksiState extends State<TambahTransaksi> {
  late DatabaseHandler handler;

  final _formKey = GlobalKey<FormState>();

  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final hargaController = TextEditingController();

  final List<DropdownMenuItem<dynamic>> listData = [];

  int dropdownValue = 0;

  late var dropDownItemsMap;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    hargaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    handler = DatabaseHandler();
  }

  void tambahTukangOjek() {
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      // await addTukangOjek();
      setState(() {});
    });
  }

  // Future<int> addTukangOjek() async {
  //   List<TukangOjek> listTukangOjek = [
  //     TukangOjek(
  //       nama: namaController.text,
  //       nopol: nopolController.text,
  //     ),
  //   ];

  //   return await handler.insertTukangOjek(listTukangOjek);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Saham'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Nama Tukang Ojek"),
              FutureBuilder(
                  future: handler.retrieveTukangOjek(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TukangOjek>> snapshot) {
                    if (snapshot.hasData) {
                      dropDownItemsMap = {};

                      for (var element in snapshot.data!) {
                        int index = snapshot.data!.indexOf(element);
                        dropDownItemsMap[index] = element;

                        listData.add(DropdownMenuItem(
                            child: Text(element.nama), value: index));
                      }
                    }
                    return DropdownButton(
                      value: dropdownValue,
                      items: listData,
                      onChanged: (value) {
                        int selectedIndex = value as int;
                        setState(() {
                          dropdownValue = dropDownItemsMap[selectedIndex].id;
                        });
                        print(dropdownValue);
                      },
                    );
                  }),
              const SizedBox(height: 20),
              const Text("Harga"),
              TextFormField(
                controller: hargaController,
                decoration: const InputDecoration(
                  hintText: 'Harga',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    tambahTukangOjek();
                    widget.onPressed();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data berhasil disimpan')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

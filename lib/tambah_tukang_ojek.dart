import 'package:assasment2_ppbl/models/tukang_ojek.dart';
import 'package:assasment2_ppbl/sqlite_service.dart';
import 'package:flutter/material.dart';

class TambahTukangOjek extends StatefulWidget {
  const TambahTukangOjek({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  State<TambahTukangOjek> createState() => _TambahTukangOjekState();
}

class _TambahTukangOjekState extends State<TambahTukangOjek> {
  late DatabaseHandler handler;

  final _formKey = GlobalKey<FormState>();

  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final namaController = TextEditingController();
  final nopolController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    namaController.dispose();
    nopolController.dispose();
    super.dispose();
  }

  void tambahTukangOjek() {
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      await addTukangOjek();
      setState(() {});
    });
  }

  Future<int> addTukangOjek() async {
    List<TukangOjek> listTukangOjek = [
      TukangOjek(
        nama: namaController.text,
        nopol: nopolController.text,
      ),
    ];

    return await handler.insertTukangOjek(listTukangOjek);
  }

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
              const Text("Nama"),
              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  hintText: 'Nama',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text("Nomor Polisi"),
              TextFormField(
                controller: nopolController,
                decoration: const InputDecoration(
                  hintText: 'Nomor Polisi',
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
                      const SnackBar(
                          content: Text('Data saham berhasil disimpan')),
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

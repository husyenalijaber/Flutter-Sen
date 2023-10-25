import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Memulai aplikasi dengan widget MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataListScreen(), 
	  // Menetapkan DataListScreen sebagai tampilan awal aplikasi
    );
  }
}

class DataListScreen extends StatefulWidget {
  @override
  _DataListScreenState createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  List<String> data = ['Data 1', 'Data 2', 'Data 3']; // Daftar data
  int? editedIndex; // Indeks data yang sedang diedit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data List'), // Judul AppBar
      ),
      body: ListView.builder(
        itemCount: data.length, // Jumlah item dalam daftar
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index]), 
			// Menampilkan data pada indeks tertentu
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit), // Tombol Edit
                  onPressed: () {
                    setState(() {
                      editedIndex = index; 
					  // Mengatur indeks yang sedang diedit
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDataScreen(
                          data: data[index],
                          onEdit: (editedData) {
                            setState(() {
                              data[index] = editedData; 
							  // Mengupdate data yang diedit
                            });
                          },
                        ),
                      ),
                    ).then((value) {
                      setState(() {
                        editedIndex = null; 
						// Menghentikan mode edit
                      });
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete), // Tombol Hapus
                  onPressed: () {
                    setState(() {
                      data.removeAt(index); 
					  // Menghapus data pada indeks tertentu
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDataScreen(
                onAdd: (newData) {
                  setState(() {
                    data.add(newData); // Menambahkan data baru
                  });
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add), // Tombol tambah data
      ),
    );
  }
}

class EditDataScreen extends StatefulWidget {
  final String data;
  final Function(String) onEdit;

  EditDataScreen({required this.data, required this.onEdit});

  @override
  _EditDataScreenState createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'), // Judul AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Data'), 
			  // Input data yang akan diubah
            ),
            ElevatedButton(
              onPressed: () {
                widget.onEdit(controller.text); // Menyimpan perubahan data
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('Save'), // Tombol Simpan
            ),
          ],
        ),
      ),
    );
  }
}

class AddDataScreen extends StatefulWidget {
  final Function(String) onAdd;

  AddDataScreen({required this.onAdd});

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'), // Judul AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Data'), // Input data baru
            ),
            ElevatedButton(
              onPressed: () {
                widget.onAdd(controller.text); // Menambahkan data baru
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('Add'), // Tombol Tambah
            ),
          ],
        ),
      ),
    );
  }
}

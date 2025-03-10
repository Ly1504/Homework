Bài 1:

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  CheckAgeState createState() => CheckAgeState();
}

class CheckAgeState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String message = '';

  void _checkAge() {
    String name = nameController.text.trim();
    int? age = int.tryParse(ageController.text);

    if (name.isEmpty) {
      setState(() {
        message = "Vui lòng nhập họ và tên";
      });
      return;
    }

    if (age == null) {
      setState(() {
        message = "Vui lòng nhập tuổi hợp lệ";
      });
      return;
    }

    setState(() {
      if (age < 0) {
        message = "Tuổi không hợp lệ";
      } else if (age < 2) {
        message = "Em bé";
      } else if (age <= 6) {
        message = "Trẻ em";
      } else {
        message = "Người lớn";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thực hành 1")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(nameController, "Họ và Tên", TextInputType.text),
            SizedBox(height: 10),
            _buildTextField(
                ageController, "Tuổi", TextInputType.number, true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAge,
              child: Text("Check Tuổi"),
            ),
            SizedBox(height: 20),
            Text(message),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, TextInputType type,
      [bool isNumber = false]) {
    return TextField(
      controller: controller,
      keyboardType: type,
      inputFormatters: isNumber ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

Bài 2:

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LibraryApp(),
  ));
}

class LibraryApp extends StatefulWidget {
  @override
  _LibraryAppState createState() => _LibraryAppState();
}

class _LibraryAppState extends State<LibraryApp> {
  TextEditingController _employeeController = TextEditingController();
  TextEditingController _bookController = TextEditingController();

  List<String> books = ["Sách 01", "Sách 02"];
  List<String> selectedBooks = []; // Sách được chọn

  void _addBook() {
    if (_bookController.text.isNotEmpty) {
      setState(() {
        books.add(_bookController.text);
        _bookController.clear();
      });
    }
  }

  void _toggleSelection(String book) {
    setState(() {
      if (selectedBooks.contains(book)) {
        selectedBooks.remove(book);
      } else {
        selectedBooks.add(book);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quản lý Thư viện")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Nhân viên:"),
            TextField(controller: _employeeController),
            SizedBox(height: 20),

            Text("Danh sách sách:"),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(books[index]),
                    leading: Checkbox(
                      value: selectedBooks.contains(books[index]),
                      onChanged: (value) => _toggleSelection(books[index]),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: _addBook, child: Text("Thêm sách")),
          ],
        ),
      ),
    );
  }
}
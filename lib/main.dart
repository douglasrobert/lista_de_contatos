import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(MyApp());

class Person {
  String name;
  String imagePath;

  Person(this.name, this.imagePath);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Person> people = [];
  File? selectedImage;

  final picker = ImagePicker();

  void _openImagePicker(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void _addPerson() {
    if (selectedImage != null) {
      people.add(Person("John", selectedImage!.path));
      setState(() {
        selectedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Pessoas'),
      ),
      body: Column(
        children: <Widget>[
          selectedImage != null
              ? Image.file(
                  selectedImage!,
                  height: 150,
                )
              : Text('Nenhuma imagem selecionada.'),
          ElevatedButton(
            onPressed: () => _openImagePicker(context),
            child: Text('Selecionar Imagem'),
          ),
          ElevatedButton(
            onPressed: () => _addPerson(),
            child: Text('Adicionar Pessoa'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(people[index].imagePath)),
                  ),
                  title: Text(people[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

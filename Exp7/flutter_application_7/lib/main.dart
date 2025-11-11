import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Maths Formulae",
    home: FormulaeScreen(), //stateful widget
  ));
}
class FormulaeScreen extends StatefulWidget {
  const FormulaeScreen({super.key});

  @override
  State<FormulaeScreen> createState() => _FormulaeScreenState();
}

class _FormulaeScreenState extends State<FormulaeScreen> {

  //state variables
  final _formkey = GlobalKey<FormState>();
  final _namecontoller = TextEditingController();
  final _formulacontoller = TextEditingController();
  final _categorycontoller = TextEditingController();
  String _status ="";

  //database instance
  final CollectionReference formulae = FirebaseFirestore.instance.collection("Formulae");

  Future<void> _addFormula() async{
    if(_formkey.currentState!.validate()){
      await formulae.add({
        'name': _namecontoller.text,
        'category':_categorycontoller.text,
        'formula':_formulacontoller.text
      });
      _namecontoller.clear();
      _categorycontoller.clear();
      _formulacontoller.clear();

      setState(){
        _status ="Data Saved Successfully";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Maths Formulae"),backgroundColor: Colors.amber),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [

                    TextFormField(
                      controller: _namecontoller,
                      decoration: InputDecoration(
                        labelText: "Enter the name for formula",
                        border: OutlineInputBorder(),
                      ),
                      validator:(value) => 
                      value == null || value.isEmpty ? "Please enter the formula name!!": null,
                    ),
                    SizedBox(height: 10,),

                    TextFormField(
                      controller: _formulacontoller,
                      decoration: InputDecoration(
                        labelText: "Enter the formula",
                        border: OutlineInputBorder(),
                      ),
                      validator:(value) => 
                      value == null || value.isEmpty ? "Please enter the formula !!": null,
                    ),
                    SizedBox(height: 10,),

                    TextFormField(
                      controller: _categorycontoller,
                      decoration: InputDecoration(
                        labelText: "Enter the category",
                        border: OutlineInputBorder(),
                      ),
                      validator:(value) => 
                      value == null || value.isEmpty ? "Please enter the category!!": null,
                    ),
                    SizedBox(height: 10,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _addFormula,
                      child: Text('Save Details'),
                    ), // ElevatedButton
                    SizedBox(height: 10),
                    Text(_status,style:TextStyle(color:Colors.green,))

                  ],
                )
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: formulae.snapshots(), 
                builder: (context, snapshot){
                  if(snapshot.hasError){
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }
                  final records = snapshot.data!.docs;
                  if(records.isEmpty){
                    return Center(child: Text("No Formula(e) Found"));
                  }
                  return ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index){
                      final formula = records[index];
                      return ListTile(

                        title: Text(formula['name']),
                        subtitle: Text("CATEGORY: ${formula['category'].toString()} FORMULA: ${formula['formula'].toString()} "),
                      );
                    }
                  );
                }
              )
            )
          ],
        ),
      )
    );
  }
}
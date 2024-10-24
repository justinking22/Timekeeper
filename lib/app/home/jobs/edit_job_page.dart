import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timekeeper/app/home/models/job.dart';
import 'package:timekeeper/common_widgets/show_alert_dialog.dart';
import 'package:timekeeper/common_widgets/show_exception_alert_dialog.dart';
import 'package:timekeeper/services/database.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({required this.database});
  final DataBase database;
  static Future<void> show(BuildContext context) async {
    final database = Provider.of<DataBase>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddJobPage(
          database: database,
        ),
      ),
    );
  }

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _ratePerHour;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final jobs = await widget.database.jobStream().first;
        final allNames = jobs.map((job) => job!.name).toList();
        if (allNames.contains(_name)) {
          showAlertDialog(context,
              title: 'Name already used',
              content: 'Please choose a different name',
              defaultActionText: 'OK');
        } else {
          final job = Job(name: _name!, ratePerHour: _ratePerHour!);
          await widget.database.createJob(job);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(
          context,
          title: 'Operation failed',
          exception: e,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 2.0,
        title: Text(
          'New Job',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            onPressed: _submit,
          )
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Job Name'),
        validator: (value) => value!.isNotEmpty ? null : 'Name can\'t be empty',
        onChanged: (value) => _name = value,
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Rate Per Hour',
        ),
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
        onChanged: (value) => _ratePerHour = int.tryParse(value),
      )
    ];
  }
}

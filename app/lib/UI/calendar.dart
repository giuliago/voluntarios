import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //this is an external package for formatting date and time

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate;

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(2020),
            //what will be the previous supported year in picker
            lastDate: DateTime(2050)
                ) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        title: Text('Data do evento'),
        subtitle: Text(_selectedDate == null //ternary expression to check if date is null
            ? 'Nenhuma data selecionada!'
            : 'Data: ${DateFormat.yMMMd().format(_selectedDate)}'),
        leading: Icon(Icons.calendar_today),
        onTap: _pickDateDialog
        ),      
      );
  }
}
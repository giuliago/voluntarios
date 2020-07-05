import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voluntarios/UI/signUp.dart'; //this is an external package for formatting date and time

class DatePicker extends StatefulWidget {
  final int firstDate;
  final int lastDate;
  final int stateVar;
  final int style;

  DatePicker(
      {Key key, this.firstDate, this.lastDate, this.stateVar, this.style})
      : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate;

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDatePickerMode:
                widget.style == 1 ? DatePickerMode.year : DatePickerMode.day,
            initialDate:
                widget.style == 1 ? DateTime(widget.firstDate) : DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(widget.firstDate),
            //what will be the previous supported year in picker
            lastDate: DateTime(widget
                .lastDate)) //what will be the up to supported date in picker
        .then((pickedDate) {
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

  Widget state1(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        title: Text('Data do evento'),
        subtitle: Text(
            _selectedDate == null //ternary expression to check if date is null
                ? 'Nenhuma data selecionada!'
                : 'Data: ${DateFormat.yMMMd().format(_selectedDate)}'),
        leading: Icon(Icons.calendar_today),
        onTap: () => _pickDateDialog(),
      ),
    );
  }

  Widget state2(BuildContext context) {
    return SizedBox(
        child: ListTile(
      contentPadding: EdgeInsets.all(0),
      onTap: () => _pickDateDialog(),
      title: Align(
        child: Text('Data de nascimento',
            style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        alignment: Alignment(-1.5, 0),
      ),
      subtitle: Align(
        child: Text(
          _selectedDate == null //ternary expression to check if date is null
              ? 'Não selecionado!'
              : 'Data: ${DateFormat.yMMMd().format(_selectedDate)}',
          style: TextStyle(color: Colors.lightGreen),
        ),
        alignment: Alignment(-1.4, 0),
      ),
      leading: Icon(Icons.calendar_today),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.stateVar == 1 ? state1(context) : state2(context));
  }
}

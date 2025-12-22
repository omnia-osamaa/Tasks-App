import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/text_form_field_helper.dart';

class ShowBottomSheetWidget extends StatefulWidget {
  const ShowBottomSheetWidget({
    super.key,
    this.onTapFlag,
    this.onTapSend,
    this.onTapTimer,
    required this.titleTask,
    required this.descriptionTask,
    this.selectedDate,
    required this.priority,
    required this.dialogTitle,
  });

  final void Function()? onTapTimer;
  final void Function()? onTapFlag;
  final void Function()? onTapSend;
  final TextEditingController titleTask;
  final TextEditingController descriptionTask;
  final DateTime? selectedDate;
  final int priority;
  final String dialogTitle;

  @override
  State<ShowBottomSheetWidget> createState() => _ShowBottomSheetWidgetState();
}

class _ShowBottomSheetWidgetState extends State<ShowBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          Text(
            widget.dialogTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff24252C),
            ),
          ),
          SizedBox(height: 14),
          TextFormFieldHelper(hint: 'Do math homework', controller: widget.titleTask),
          SizedBox(height: 14),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xff6E6A7C),
            ),
          ),
          TextFormFieldHelper(
            hint: 'Enter your description',
            controller: widget.descriptionTask,
          ),
          SizedBox(height: 17),
          Row(
            children: [
              GestureDetector(
                onTap: widget.onTapTimer,
                child: Row(
                  children: [
                    Image.asset("assets/icons/timer.png"),
                    SizedBox(width: 5),
                    if (widget.selectedDate != null)
                      Text(
                        "${widget.selectedDate!.day}/${widget.selectedDate!.month}",
                        style: TextStyle(color: Colors.grey),
                      )
                  ],
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: widget.onTapFlag,
                child: Row(
                  children: [
                    Image.asset("assets/icons/flag_icon.png"),
                    SizedBox(width: 5),
                    Text(
                      "${widget.priority}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: widget.onTapSend,
                child: Image.asset("assets/icons/send_icon.png"),
              ),
            ],
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
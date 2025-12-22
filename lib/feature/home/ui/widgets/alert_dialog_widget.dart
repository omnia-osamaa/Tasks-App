import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/material_button_widget.dart';
import 'package:tasky/feature/home/ui/widgets/container_prority_widget.dart';


class AlertDialogwidget extends StatefulWidget {
   const AlertDialogwidget({super.key , required this.onTap});

   final void Function(int) onTap;
  @override
  State<AlertDialogwidget> createState() => _AlertDialogwidgetState();
}

class _AlertDialogwidgetState extends State<AlertDialogwidget> {
 final List<int>indexDataNumber =[1,2,3,4,5,6,7,8,9,10];

 int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Task priority",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff24252C)
                      ),
                    ),
                    Divider(
                      color: Color(0xff979797),
                      thickness: 1,
                    ),
                    SizedBox(height: 10,),

                 Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: indexDataNumber
                  .map(
                    (index)=>ContainerPriorityWidget(
                      index: index,
                       isSelected: selectedIndex == index,
                       onTap: () {
                         selectedIndex = index;
                         setState(() {
                           
                         });
                       },
                       )
                       )
                       .toList(),
       
                 )
                  ],
                ),
               actions: [
                Row(
                  spacing: 10,
                  children: [
                    Expanded(child: MaterialButtonWidget(title: "save",
                    onPressed: () {
                      widget.onTap(selectedIndex);
                      Navigator.pop(context);
                    },
                    ),
                    ),

                     Expanded(child: MaterialButtonWidget(title: "cancel",
                     colorBg: Colors.transparent,
                     textColor: Color(0xff5F33E1),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    ),
                    ),
                  ],
                )
               ]
               );
  }
}


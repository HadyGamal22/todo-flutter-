import 'package:flutter/material.dart';

Widget customeButton({
  required String text,
  required double width,
  required VoidCallback function,
  required Color color,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget textForm({
  VoidCallback? onTap,
  required bool secureText,
  required Function function,
  required String text,
  required String? Function(String?) validate,
  IconData? suffixIcon,
  required IconData? prefixIcon,
  bool ? isClickable=true,
  required TextEditingController controller,
}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      validator: (value) {
        return validate(value);
      },
      controller: controller,
      // onFieldSubmitted: su,
      obscureText: secureText,
      decoration: InputDecoration(
        hintText: text,
        suffixIcon: IconButton(
          onPressed: function(),
          icon: Icon(
            suffixIcon,
          ),
        ),
        prefixIcon: Icon(
          prefixIcon,
        ),
        border: const OutlineInputBorder(),
      ),
    );

Widget taskItem(task){
  return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 24,
              child: Text(
                '${task['id']}',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${task['task_name']}',
                ),
                Text(
                  '${task['task_data']}',
                ),
              ],
            ),
          ],
        ),
      );
     
}
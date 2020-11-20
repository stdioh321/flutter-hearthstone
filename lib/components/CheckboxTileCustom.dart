import 'package:flutter/material.dart';

class CheckboxTileCustom extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;
  final Text title;
  CheckboxTileCustom({
    this.value,
    this.onChanged,
    this.title,
  });

  @override
  _CheckboxTileCustomState createState() => _CheckboxTileCustomState();
}

class _CheckboxTileCustomState extends State<CheckboxTileCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          bool v = widget.value ?? false;
          v = !v;
          widget.onChanged(v);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: widget.value,
              onChanged: widget.onChanged,
            ),
            widget.title
          ],
        ),
      ),
    );
  }
}

// class CheckboxTileCustom extends StatefulWidget {
//   String title;
//   Function onChange;

//   CheckboxTileCustom({this.title, this.onChange});
//   @override
//   _CheckboxTileCustomState createState() => _CheckboxTileCustomState();
// }

// class _CheckboxTileCustomState extends State<CheckboxTileCustom> {
//   bool v = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _checkKey.currentState.lis
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           CheckboxListTile(),
//           Checkbox(
//             value: v,
//             onChanged: (bool tmp) {
//               v = tmp;
//               //
//               print(v);
//               setState(() {});
//             },
//           ),
//           Text(widget.title)
//         ],
//       ),
//     );
//   }
// }

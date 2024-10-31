// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';

// class CategorySelector extends StatefulWidget {
//   const CategorySelector({super.key});

//   @override
//   _CategorySelectorState createState() => _CategorySelectorState();
// }

// class _CategorySelectorState extends State<CategorySelector> {
//   @override
//   Widget build(BuildContext context) {
//     double hauteur = MediaQuery.of(context).size.height;
//     return Container(
//       height: hauteur / 12,
//       color: Theme.of(context).colorScheme.secondary,
//       child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
//           Widget>[
//         Column(children: const <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.amp_stories,
//               color: Colors.blue,
//               size: iconSize,
//             ),
//             onPressed: null,
//           ),
//           Text(
//             "Status",
//             style: TextStyle(fontSize: iconTextSize),
//           )
//         ]),
//         Column(
//           children: const <Widget>[
//             IconButton(
//               icon: Icon(Icons.call, color: Colors.blue, size: iconSize),
//               onPressed: null,
//             ),
//             Text(
//               "Calls",
//               style: TextStyle(fontSize: iconTextSize),
//             )
//           ],
//         ),
//         Column(
//           children: const <Widget>[
//             IconButton(
//               icon: Icon(Icons.camera_alt, color: Colors.blue, size: iconSize),
//               onPressed: null,
//             ),
//             Text(
//               "Camera",
//               style: TextStyle(fontSize: iconTextSize),
//             )
//           ],
//         ),
//         Column(
//           children: const <Widget>[
//             IconButton(
//               icon: Icon(Icons.chat, color: Colors.blue, size: iconSize),
//               onPressed: null,
//             ),
//             Text(
//               "Chats",
//               style: TextStyle(fontSize: iconTextSize),
//             )
//           ],
//         ),
//         Column(
//           children: const <Widget>[
//             IconButton(
//               icon: Icon(Icons.settings, color: Colors.blue, size: iconSize),
//               onPressed: null,
//             ),
//             Text(
//               "Settings",
//               style: TextStyle(fontSize: iconTextSize),
//             )
//           ],
//         ),
//       ]),
//     );
//   }
// }

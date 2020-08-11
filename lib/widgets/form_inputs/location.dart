// import 'package:flutter/material.dart';
// import 'package:map_view/map_view.dart';

// class LocationInput extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _LocationInputState();
//   }
// }

// class _LocationInputState extends State<LocationInput> {
//   final FocusNode _addressInputFocusNode = FocusNode();
//   Uri _staticMapUri;
//   @override
//   void initState() {
//     _addressInputFocusNode.addListener(_updateLocation);
//     getStaticMap();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _addressInputFocusNode.removeListener(_updateLocation);
//     super.dispose();
//   }

//   void getStaticMap() {
//     final StaticMapProvider staticMapViewProvider =
//         StaticMapProvider('AIzaSyBZkG-lOrvPq0YKCwxFLvzVUV7_vzH_s70');
//     final Uri staticMapUri = staticMapViewProvider.getStaticUriWithMarkers(
//         [Marker('position', 'position', 41.40338, 2.17402)],
//         center: Location(41.40338, 2.17402),
//         width: 500,
//         height: 300,
//         maptype: StaticMapViewType.roadmap
//         );
//       setState(() {
//         _staticMapUri = staticMapUri;
//       });

//   }
//   void _updateLocation(){}

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Column(children: <Widget>[
//       TextFormField(
//         focusNode: _addressInputFocusNode,
//       ),
//       SizedBox(height:10.0),
//       Image.network(_staticMapUri.toString())
//     ]);
//   }
// }

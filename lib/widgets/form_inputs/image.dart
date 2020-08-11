import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  // void _getImage(BuildContext context,ImageSource source){
  //   ImagePicker.pickImage(source: null)
  // }
  File _image;
  final picker = ImagePicker();

  Future getImage(BuildContext context, ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image = File(pickedFile.path);
    });
    Navigator.pop(context);
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'pick an image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () {
                    getImage(context, ImageSource.camera);
                  },
                  child: Text('Use Camera'),
                  textColor: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 5.0),
                FlatButton(
                    onPressed: () {
                      getImage(context, ImageSource.gallery);
                    },
                    child: Text('User Gallery'),
                    textColor: Theme.of(context).primaryColor),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final buttonColor = Theme.of(context).accentColor;
    return Column(children: <Widget>[
      OutlineButton(
          borderSide: BorderSide(color: buttonColor, width: 2.0),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(width: 5.0),
              Text(
                'Add Image',
                style: TextStyle(color: buttonColor),
              )
            ],
          )),
      SizedBox(height: 10.0),
      _image == null
          ? Text('pick an image')
          : Image.file(
              _image,
              fit: BoxFit.cover,
              height: 300.0,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
            )
    ]);
  }
}

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text('pick an image',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0),
                FlatButton(
                  onPressed: () {},
                  child: Text('Use Camera'),
                  textColor: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 5.0),
                FlatButton(
                    onPressed: () {},
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
          onPressed: (){
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
          ))
    ]);
  }
}

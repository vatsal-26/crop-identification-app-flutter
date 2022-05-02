import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'show_results.dart';
import 'package:tflite/tflite.dart';

bool _loading;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  List _outputs;
  List top3;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  // final _imageUrls = [
  //   "https://spectrumproperties.co.ug/wp-content/uploads/2018/08/IMG_7973.jpg",
  //   "https://spectrumproperties.co.ug/wp-content/uploads/2018/08/IMG_8427.jpg",
  //   "https://spectrumproperties.co.ug/wp-content/uploads/2018/08/IMG_8296.jpg",
  //   "https://spectrumproperties.co.ug/wp-content/uploads/2018/08/IMG_8691.jpg"
  // ];

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      classifyImage(image);
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      threshold: 0.3,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      //Declare List _outputs in the class which will be used to show the classified classs name and confidence
      _outputs = output;

      print(output);
    });

    showDifferentPage(image);
  }

  void showDifferentPage(File image) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ShowResults(image: image, outputs: _outputs)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      // Text(
      //   'Crop Identification App',
      //   style: TextStyle(
      //       fontSize: 25,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.greenAccent),
      //   textAlign: TextAlign.center,
      // ),
      Padding(
        padding: EdgeInsets.only(top: 1),
      ),
      SizedBox(
          height: 300,
          width: 400.0,
          child: Carousel(
            images: [
              AssetImage('assets/1.jpg'),
              AssetImage('assets/2.jpg'),
              AssetImage('assets/3.jpg'),
              AssetImage('assets/4.png'),
            ],
          )),
      Padding(padding: EdgeInsets.only(top: 20)),
      Image.asset(
        'assets/icon.png',
        width: 100,
        height: 220,
      ),
      Padding(
        padding: EdgeInsets.only(top: 20),
      ),
      Center(
        // child: RaisedButton(
        //     // elevation: 15,
        //     padding: EdgeInsets.all(20),
        //     onPressed: getImage,
        //     child: Text(
        //       "Identify Crop",
        //       style: TextStyle(fontSize: 16),
        //     ),
        //     color: Colors.blue[500]),
        child: RaisedButton(
            onPressed: getImage,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)
            ),
            elevation: 0.0,
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text("Identify Crop",
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight:FontWeight.w800),
                ),
              ),
            )
        ),
      )
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(
  home:ProfileApp(),
));

class ProfileApp extends StatelessWidget {

  void funcOpenMailComposer() async{

    final mailtoLink = Mailto(
      to: ['abhishekmishra5903@gmail.com'],
      subject: '',
      body: '',
    );
    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  color: Colors.black,
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                // child: Center(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icon.png'),
                      //fit: BoxFit.cover
                      fit: BoxFit.fill),
                ),
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     CircleAvatar(
                  //       backgroundImage: NetworkImage(
                  //         "icon.jpg",
                  //       ),
                  //       radius: 50.0,
                  //     ),
                  //     SizedBox(
                  //       height: 10.0,
                  //     ),
                  //     Text(
                  //       "Alice James",
                  //       style: TextStyle(
                  //         fontSize: 22.0,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       height: 10.0,
                  //     ),
                  //     // Card(
                  //     //   margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                  //     //   clipBehavior: Clip.antiAlias,
                  //     //   color: Colors.white,
                  //     //   elevation: 5.0,
                  //     //   child: Padding(
                  //     //     padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                  //     //     child: Row(
                  //     //       children: <Widget>[
                  //     //         Expanded(
                  //     //           child: Column(
                  //     //
                  //     //             children: <Widget>[
                  //     //               Text(
                  //     //                 "Posts",
                  //     //                 style: TextStyle(
                  //     //                   color: Colors.redAccent,
                  //     //                   fontSize: 22.0,
                  //     //                   fontWeight: FontWeight.bold,
                  //     //                 ),
                  //     //               ),
                  //     //               SizedBox(
                  //     //                 height: 5.0,
                  //     //               ),
                  //     //               Text(
                  //     //                 "5200",
                  //     //                 style: TextStyle(
                  //     //                   fontSize: 20.0,
                  //     //                   color: Colors.pinkAccent,
                  //     //                 ),
                  //     //               )
                  //     //             ],
                  //     //           ),
                  //     //         ),
                  //     //         Expanded(
                  //     //           child: Column(
                  //     //
                  //     //             children: <Widget>[
                  //     //               Text(
                  //     //                 "Followers",
                  //     //                 style: TextStyle(
                  //     //                   color: Colors.redAccent,
                  //     //                   fontSize: 22.0,
                  //     //                   fontWeight: FontWeight.bold,
                  //     //                 ),
                  //     //               ),
                  //     //               SizedBox(
                  //     //                 height: 5.0,
                  //     //               ),
                  //     //               Text(
                  //     //                 "28.5K",
                  //     //                 style: TextStyle(
                  //     //                   fontSize: 20.0,
                  //     //                   color: Colors.pinkAccent,
                  //     //                 ),
                  //     //               )
                  //     //             ],
                  //     //           ),
                  //     //         ),
                  //     //         Expanded(
                  //     //           child: Column(
                  //     //
                  //     //             children: <Widget>[
                  //     //               Text(
                  //     //                 "Follow",
                  //     //                 style: TextStyle(
                  //     //                   color: Colors.redAccent,
                  //     //                   fontSize: 22.0,
                  //     //                   fontWeight: FontWeight.bold,
                  //     //                 ),
                  //     //               ),
                  //     //               SizedBox(
                  //     //                 height: 5.0,
                  //     //               ),
                  //     //               Text(
                  //     //                 "1300",
                  //     //                 style: TextStyle(
                  //     //                   fontSize: 20.0,
                  //     //                   color: Colors.pinkAccent,
                  //     //                 ),
                  //     //               )
                  //     //             ],
                  //     //           ),
                  //     //         ),
                  //     //       ],
                  //     //     ),
                  //     //   ),
                  //     // )
                  //   ],
                  // ),
                // ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "About Developers:",
                    style: TextStyle(
                        color: Colors.blue[600],
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('For the use of Govt. of India, developed by Abhishek Mishra, Aditya Shetkar and Prasad Nayak as their final year project\n',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,

            child: RaisedButton(
                onPressed: funcOpenMailComposer,
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
                    child: Text("Contact me",
                      style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight:FontWeight.w800),
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
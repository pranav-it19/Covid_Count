import 'package:covid_count/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
    
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
              display1: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              headline: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal))),
      home: startScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Virus.jpg'),
                      fit: BoxFit.cover)),
            ),
          ),
          Expanded(
              child: Column(
              
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: '',
                      style: Theme.of(context).textTheme.display1)
                ]),
              )
            ],
          )
          ),
          FittedBox(
              child: GestureDetector(
                onTap: (){
                Navigator.push(context,MaterialPageRoute(
                  builder:(context){
                    return Dashboard();
                  }
                ));
                },
                              child: Container(
                margin: EdgeInsets.only(bottom:20),
                 padding:EdgeInsets.symmetric(horizontal:10,vertical:15),
                 decoration:BoxDecoration(
                   borderRadius:BorderRadius.circular(25.0),
                   color:Colors.red
                 ),
                 child: Row(
                   children:[
                     Text('View Details',style: TextStyle(fontSize: 18),),
                     Icon(Icons.arrow_forward_ios)
                   ]
                 ),),
              ),
                      
          )
        ],
      ),
    );
  }
}

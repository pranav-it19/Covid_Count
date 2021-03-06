
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
Future<Covid> fetchdata()async{
  final response=await http
  .get('https://corona.lmao.ninja/v2/countries/india?yesterday=false');
  if(response.statusCode==200){
    return Covid.fromJson(json.decode(response.body));
  }
  else{
    throw Exception('Failed to load');
  }
}
class Covid{
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int updated;
  Covid({this.active,this.cases,this.deaths,this.recovered,this.updated});
  factory Covid.fromJson(Map<String,dynamic>json){
    return Covid(
      cases: json['cases'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      active:json['active'],
      updated: json['updated']
    );
  }
}



class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<Covid> futureCovid;
  @override
  void initState() {
    futureCovid=fetchdata();
    super.initState();
  }
  String _dataValue(int timeInMillis){
    var date=DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    var formattedDate=DateFormat("dd-MM-yyyy hh:mm").format(date);
    return formattedDate.toString();
  } 
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Covid>(
        future: futureCovid,
        builder: (context,snapshot){
          if(snapshot.hasData){
          return Column(
            children:[
              Expanded(
                flex:4,
                child: Container(
                  decoration: BoxDecoration(
                    image:DecorationImage(
                      image:AssetImage('assets/Mask.jfif'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter
                    )
                  ),
                )
                ),
                Expanded(
                  flex:2,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding:EdgeInsets.all(8),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text('Cases:',style:TextStyle(
                            fontSize: 30,
                            fontWeight:FontWeight.bold,
                            color: Colors.amberAccent)
                            ),
                            Text(snapshot.data.cases.toString(),
                            style:TextStyle(fontSize: 25))
                        ]
                      ),
                    ),
                  ) ,
                  ),
                   Expanded(
                  flex:2,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding:EdgeInsets.all(8),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text('Active',style:TextStyle(
                            fontSize: 30,
                            fontWeight:FontWeight.bold,
                            color: Colors.orangeAccent)
                            ),
                            Text(snapshot.data.active.toString(),
                            style:TextStyle(fontSize: 25))
                        ]
                      ),
                    ),
                  ) ,
                  ),
                   Expanded(
                  flex:2,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding:EdgeInsets.all(8),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text('Deaths:',style:TextStyle(
                            fontSize: 30,
                            fontWeight:FontWeight.bold,
                            color: Colors.red)
                            ),
                            Text(snapshot.data.deaths.toString(),
                            style:TextStyle(fontSize: 25))
                        ]
                      ),
                    ),
                  ) ,
                  ),
                   Expanded(
                  flex:2,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding:EdgeInsets.all(8),
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text('Recovered:',style:TextStyle(
                            fontSize: 30,
                            fontWeight:FontWeight.bold,
                            color: Colors.green)
                            ),
                            Text(snapshot.data.recovered.toString(),
                            style:TextStyle(fontSize: 25))
                        ]
                      ),
                    ),
                  ) ,
                  ),
                   Expanded(
                  flex:1 ,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding:EdgeInsets.all(8),
                      color: Colors.black12,
                      child: Row(
                        children:[
                          Text('Designed by Pranav K\nLast Updated:${_dataValue(snapshot.data.updated)}'),
                        ]
                      ),
                    ),
                  ) ,
                  ),
                  
                  
                  
                  
            ]
          );
          }
          else if(snapshot.hasError){
          return Text('${snapshot.error}');
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        ),

    );       
    
  }
}
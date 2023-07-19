import 'dart:convert';
import 'package:crm/models/base_url.dart';
import 'package:crm/models/team.dart';
import 'package:crm/profile/profil.dart';
import 'package:crm/screens/team/widgets/team_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../home/home_widgets/navigation_drawer_widget.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  
  GlobalKey<ScaffoldState> _scaffoldKEY = GlobalKey<ScaffoldState>();
  late Future<List<Team>> _teamData;

  @override
  void initState() {
    super.initState();
    _teamData = fetchTeams();
  }

  Future<List<Team>> fetchTeams() async {
    final token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9leGFtcGxlLm9yZyIsImF1ZCI6Imh0dHA6XC9cL2V4YW1wbGUuY29tIiwiZXhwIjoxNjg5Njg3NzIyLCJkYXRhIjoiYW1qYWQifQ.Im_sHaWarNaPTKxQM_GUwLNlnfidC09CIzMFUyaStVQ"; // Replace with your token
    final response = await http.get(
      Uri.parse('${BaseUrl.BASE_URL}/users/read.php'),
      headers: {'Authorization': 'Bearer $token'},
    );

    print('API Request: ${BaseUrl.BASE_URL}/users/read.php'); // Print API request URL

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      
    
      return data.map((json) => Team.fromJson(json)).toList();
    } else {
      print('API Request Failed with Status Code: ${response.statusCode}');
      throw Exception('Failed to fetch team data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKEY,
      drawer: NavigationDrawerWidget(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.menu_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          _scaffoldKEY.currentState?.openDrawer(),
                    ),
                    Text(
                      "Team",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Spacer(),
                    Icon(
                      Icons.add_alert_outlined,
                      color: Colors.transparent,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PorfilePage(),
                          ),
                        );
                      },
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
              Container(
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.width * 0.87,
                child: Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                    Icon(Icons.search_outlined, color: Colors.white),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.teal.shade200,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(1, 1),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
              TeamWidget(teamList: [],),
              FutureBuilder<List<Team>>(
                future: _teamData, // Use the fetched team data
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<Team> teams = snapshot.data!;
                    return TeamWidget(teamList: teams); // Pass the team data to TeamWidget
                  } else if (snapshot.hasError) {
                    print('API Request Failed with Error: ${snapshot.error}');
                    return Text('Error: ${snapshot.error}');
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:crm/profile/profil.dart';
// import 'package:crm/route/route_helper.dart';
// import 'package:crm/screens/team/widgets/team_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../home/home_widgets/navigation_drawer_widget.dart';

// class TeamPage extends StatelessWidget {
//   GlobalKey<ScaffoldState> _scaffoldKEY=  GlobalKey<ScaffoldState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        key: _scaffoldKEY,
//       drawer: NavigationDrawerWidget(),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/bg.png"), // set your desired background image
//             fit: BoxFit.cover, // set the fit of the image
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//                Padding(
//                   padding:  EdgeInsets.all(10.0),
//                   child: Row(
//                       children: [
//                         SizedBox(height:90,),
//                         IconButton(
//                           icon: Icon(Icons.menu_outlined,color: Colors.white,),
//                           onPressed: ()=>_scaffoldKEY.currentState?.openDrawer(), ),
//                        Text("Team",style: TextStyle(color: Colors.white,fontSize: 20),),
//                         Spacer(),
                      
//                         Icon(Icons.add_alert_outlined,color: Colors.transparent,),
//                         SizedBox(width: MediaQuery.of(context).size.width*0.05,),
//                        InkWell(
//                           onTap: () {
//                              Navigator.of(context).push(MaterialPageRoute(builder:(context) => PorfilePage() ));
//                           },
//                           child: Icon(Icons.person,color: Colors.white,)),
//                         SizedBox(width: MediaQuery.of(context).size.width*0.05,),
//                       ]
//                   ),
//                 ),
//               SizedBox(height:MediaQuery.of(context).size.height*0.04,),  
//               Container(
//                 height: MediaQuery.of(context).size.height*0.045,
//                 width:MediaQuery.of(context).size.width*0.87 ,
//                 child: Row(
//                   children: [
//                     SizedBox(width:MediaQuery.of(context).size.width*0.04,), 
//                     Icon(Icons.search_outlined,color:Colors.white),
//                   ],
//                 ),  
//                 decoration: BoxDecoration(
//                   color:Colors.teal.shade200,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 10,
//                       spreadRadius: 5,
//                       offset: Offset(1, 1),
//                       color:Colors.grey.withOpacity(0.1)
//                     )
//                   ]
//                 ),
//               ),
//               SizedBox(height:MediaQuery.of(context).size.height*0.04,),
//               TeamWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

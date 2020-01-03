
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';


void main() => runApp(MaterialApp(
  theme: new ThemeData(
    primaryColor: Colors.white,
    accentColor: Colors.white,
    fontFamily: 'Baloo'
  ),
  title: 'tiqgithub',
  debugShowCheckedModeBanner: false,
  home: Home(),
  ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String username ;
  Map user = {
    'login' : 'OctoGit',
    'name' : 'Octopus Github',
    'avatarUrl' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYEVpjbFmVXc0bz95fU3D_aD9i6zAXfN_Pgupa0FzIsU57b2V7Jw&s',
    'location' : 'Turkey',
    'publicRepos': 11
  };


  Future<void> getUser() async{
    try {
      Response response =await get('https://api.github.com/users/$username');
      if(response.statusCode== 200) {
        Map data = jsonDecode(response.body);
        setState(() {
          user = {
            'login' : data['login'],
            'avatarUrl':data['avatar_url'],
            'name': data['name'],
            'location': data['location'],
            'publicRepos': data['public_repos']
          };
        });
      }
      else{
        setState(() {
          user = {
            'login' : 'Not Found',
            'name' : 'Not Found',
            'avatarUrl' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqh0pxsFMzhZ2EkSEbGIHZb6u15DcPmK6qbzBLNYhRUQM7TDWR1g&s',
            'location' : 'Emptia',
            'publicRepos': -99
          };
        });
      }
    }
    catch(e){
    }
  }
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
        resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20.0,0,10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius:30.0,
                    backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/5/58/Octocat_GitHub_Mascot.png'
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Text('Github Users API',
                    style: TextStyle(
                    fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400]
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
            onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                Container(
                  width: 350,
                  height: 80,
                  child: Card(
                    color: Colors.grey[600],
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0,0,4.0,4.0),
                                  child: TextFormField(
                                    controller: _controller,
                                    onChanged : (val){
                                      setState(() {
                                        username = val;
                                      });
                                    },
                                    cursorColor: Colors.white,
                                    style: TextStyle(color: Colors.amberAccent[200]),
                                    decoration: InputDecoration(hintText: 'Username', hintStyle: TextStyle(color: Colors.grey[400]), fillColor:Colors.white,focusColor: Colors.white, prefixIcon: new Icon(Icons.assignment_ind,size: 27.0,), hoverColor: Colors.white),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 12.0, 4.0, 0),
                                child: IconButton(
                                  icon: new Icon(Icons.search, color: Colors.grey[400],),
                                  onPressed: () async{
                                    //spinkit start
                                    await getUser();
                                    _controller.clear();
                                    //spinkit finish
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ) ,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Center(
                    child: Card(
                      color: Colors.grey[900],
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),),
                      child: Container(
                        width: 350,
                        height: 450,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30.0,),
                            CircleAvatar(
                              radius:75.0,
                              backgroundImage: NetworkImage(
                                user['avatarUrl'].toString().isNotEmpty ? user['avatarUrl'] : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYEVpjbFmVXc0bz95fU3D_aD9i6zAXfN_Pgupa0FzIsU57b2V7Jw&s'
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0,5.0,15.0,0),
                              child: Divider(
                                height: 30.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(user['name'] != null ? user['name'] : 'No Name' , style: TextStyle(color: Colors.amber, fontSize: 28.0),),
                            Text( 'Login : ${user['login']}', style: TextStyle(color: Colors.grey[600], fontSize: 20.0),),
                            Text( 'Location : ${user['location']}', style: TextStyle(color: Colors.grey[600], fontSize: 20.0),),
                            Text('Repositories : ${user['publicRepos'].toString()}', style: TextStyle(color: Colors.grey[600], fontSize: 20.0),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),
          ],
        ),
      ),
    );

  }
}



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/user.dart';
import 'package:pikngrocers_client/utils/auth_helper.dart';
import 'package:pikngrocers_client/utils/database.dart';

class ProfilePage extends StatelessWidget {
  final String userId;

  ProfilePage({this.userId});

  final sampleUser = UserDisp(
    displayName: 'Grocers12',
    photoUrl:
        'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: Database().profileData(userId: userId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ProfileWid(
                          snapshot: snapshot, sampleUser: sampleUser);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('ORDERS'),
                    SizedBox(height: 10,),
                    StreamBuilder<QuerySnapshot>(
                        stream: Database().orderDetails(userId: userId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            if (snapshot.data.docs.length == 0) {
                              return Center(child: Text('No orders'));
                            } else {
                              var doc = snapshot.data.docs;
                              return ListView.builder(
                                  itemCount: doc.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ListTile(
                                        tileColor: doc[i].data()['OrderStatus'] ==
                                                'Waiting'
                                            ? Colors.deepOrange
                                            : doc[i].data()['OrderStatus'] ==
                                                    'Accepted'
                                                ? Colors.blue
                                                : Colors.green,
                                        title: doc[i].data()['OrderStatus'] ==
                                                'Waiting'
                                            ? Text(
                                                'Order waiting',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : doc[i].data()['OrderStatus'] ==
                                                    'Accepted'
                                                ? Text(
                                                    'Order Accepted',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    'Ready to Pick',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                        subtitle: doc[i].data()['OrderStatus'] ==
                                                'Waiting'
                                            ? Text(
                                                'please wait for vendor to accept your order',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : doc[i].data()['OrderStatus'] ==
                                                    'Accepted'
                                                ? Text(
                                                    'Now your products are Packing',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : Text(
                                                    'Collect your order by visiting the store',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                        trailing: doc[i].data()['OrderStatus'] ==
                                            'Waiting'
                                            ? Icon(Icons.timer,color: Colors.white,)
                                            : doc[i].data()['OrderStatus'] ==
                                            'Accepted'
                                            ? Icon(Icons.check_box_outline_blank_sharp,color: Colors.white,)
                                            : Icon(Icons.done,color: Colors.white,),
                                      ),
                                    );
                                  });
                            }
                          }
                          return Center(child: Text('Loading'));
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileWid extends StatelessWidget {
  const ProfileWid({
    Key key,
    @required this.snapshot,
    @required this.sampleUser,
  }) : super(key: key);

  final UserDisp sampleUser;
  final AsyncSnapshot<DocumentSnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = snapshot.data.data();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: kAccountColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      data['photoUrl'] == null
                          ? sampleUser.photoUrl
                          : data['photoUrl'],
                    ),
                    backgroundColor: Colors.black12,
                    radius: 60,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    data['username'] == null
                        ? sampleUser.displayName
                        : data['username'],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {})
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('${data['address']}'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${data['ph_no']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: kAccountColor,
                      ),
                      onPressed: () {})
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${data['email'] == null ? 'Email' : data['email']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: kAccountColor,
                      ),
                      onPressed: () {})
                ],
              ),
              FlatButton.icon(
                onPressed: () {
                  try {
                    AuthHelper().logout();
                  } catch (e) {
                    print(e);
                  }
                },
                icon: Icon(Icons.exit_to_app),
                label: Text('LogOut'),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/profileheader.dart';
import 'package:pikngrocers_client/screens/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key key,
    @required this.user,
  }) : super(key: key);
  final User user;
  final sampleUser = const User(
    displayName: 'Andrea Brews',
    username: '@biz84',
    photoUrl:
        'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
                          sampleUser.photoUrl,
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
                        sampleUser.displayName,
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
                  Text(
                    sampleUser.username,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 18),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: kAccountColor,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return AddressBottomSheet();
                                    });
                              })
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('No:06, 3rd street, sriram nagar[extn],'),
                            Text('Madhakottai road,'),
                            Text('Thanjavur - 613005'),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mobile number',
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
                        'Email id',
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: kAccountColor),
                labelText:
                    'House/ Flat / Block No',
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:kAccountColor))
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: kAccountColor),
                labelText: 'Street ',
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:kAccountColor))
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: kAccountColor),
                labelText: 'Locality',
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:kAccountColor))
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: kAccountColor),
                labelText: 'Landmark',
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:kAccountColor))
              ),
            ),
            SizedBox(height: 10,),
            FlatButton(
                onPressed: () {},
                color: kAccountColor,
                textColor: Colors.white,
                child: Text('Save Address',style: TextStyle(fontSize: 18),))
          ],
        ),
      ),
    );
  }
}

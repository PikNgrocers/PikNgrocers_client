import 'package:flutter/material.dart';
import 'package:pikngrocers_client/constants.dart';
import 'package:pikngrocers_client/screens/avatar.dart';
import 'package:pikngrocers_client/screens/user.dart';

class ProfileHeader extends  SliverPersistentHeaderDelegate {
  ProfileHeader({this.user,this.expandendHeight});
  final User user;
  final double expandendHeight;

  @override
  Widget build(BuildContext context,double shrinkOffset,bool overlapsContent) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 16.0),
            Avatar(photoUrl: user.photoUrl,radius: 50 ,),
            SizedBox(height: 8.0),
            if (user.displayName != null) ...[
              Text(
                user.displayName,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8.0),
            ],
            if (user.username != null) ...[
              Text(
                user.username,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 8.0),
            ],
          ],
        ),color: kAccountColor,
      ),
    );
  }

  @override
  double get maxExtent => expandendHeight;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
  return true;
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


class ProfileItem extends Equatable {
  final String title;
  final IconData icon;
  final String navigationLocation;

  const ProfileItem({
    required this.title,
    required this.icon,
    required this.navigationLocation
  });

  @override
  List<Object?> get props => [
    title,
    icon,
    navigationLocation
  ];
}
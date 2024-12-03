import 'package:dashboarweb/constants.dart';
import 'package:flutter/material.dart';

class InfoDetails {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  InfoDetails({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List adminData = [
  InfoDetails(
    title: "All Users",
    numOfFiles: 1328,
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "354",
    color: primaryColor,
    percentage: 35,
  ),
  InfoDetails(
    title: "Motor Policies",
    numOfFiles: 1328,
    svgSrc: "assets/icons/google_drive.svg",
    totalStorage: "120",
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  InfoDetails(
    title: "Travelling Policies",
    numOfFiles: 1328,
    svgSrc: "assets/icons/one_drive.svg",
    totalStorage: "145",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  InfoDetails(
    title: "Health Policies",
    numOfFiles: 5328,
    svgSrc: "assets/icons/drop_box.svg",
    totalStorage: "24",
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({required this.photoUrl, required this.radius});
  final String photoUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black54,
          width: 3.0,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.black12,
        backgroundImage: photoUrl != "" ? NetworkImage(photoUrl) : null,
        child: photoUrl == "" ? Icon(Icons.camera_alt, size: radius) : null,
      ),
    );
  }
}

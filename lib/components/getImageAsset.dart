import 'package:flutter/material.dart';

class GetImageAsset extends StatefulWidget {
  @override
  State<GetImageAsset> createState() => _GetImageAssetState();
}

class _GetImageAssetState extends State<GetImageAsset> {
  @override
  Widget build(BuildContext context) {
    
    return CircleAvatar(
      radius: 90,
      backgroundImage: AssetImage('images/avater.png'),
    );
  }
}

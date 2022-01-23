import 'package:flutter/cupertino.dart';

class GetImageAsset extends StatefulWidget {
  @override
  State<GetImageAsset> createState() => _GetImageAssetState();
}

class _GetImageAssetState extends State<GetImageAsset> {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/avater.jpg');
    Image image = Image(
      image: assetImage,
    );
    return Container(
      child: image,
    );
  }
}

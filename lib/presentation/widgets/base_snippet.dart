import 'package:flutter/material.dart';
import 'package:match_manager/presentation/widgets/custom_image.dart';

class BaseSnippet extends StatelessWidget {
  final String photo;
  final bool needPhoto;
  final Function onTap;
  final Widget child;

  BaseSnippet({
    @required this.child,
    this.needPhoto = false,
    this.photo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: InkWell(
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              needPhoto
                  ? Container(
                      child: _buildImage(photo),
                    )
                  : SizedBox.shrink(),
              Container(
                padding: EdgeInsets.all(16),
                child: child,
              ),
            ],
          ),
          elevation: 4,
        ),
      ),
    );
  }

  _buildImage(String photo) {
    return AspectRatio(
      aspectRatio: 8 / 4,
      child: SizedBox.expand(
        child: CustomImage(
          '$photo',
        ),
      ),
    );
  }
}

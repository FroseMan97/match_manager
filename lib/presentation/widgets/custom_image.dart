import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomImage extends CachedNetworkImage {
  final String photo;
  final double height;
  final BlendMode blendMode;
  final Color color;
  final Widget Function(BuildContext, ImageProvider<dynamic>) builder;
  CustomImage(this.photo,
      {this.height, this.builder, this.blendMode, this.color})
      : super(
          imageUrl: '$photo',
          imageBuilder: builder,
          height: height,
          colorBlendMode: blendMode,
          color: color,
          fit: BoxFit.fill,
          errorWidget: (context, url, error) => Image.asset(
            ERROR_IMAGE_ASSET_STRING,
            height: height,
            fit: BoxFit.fill,
          ),
        );
}

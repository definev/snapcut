import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:snapcut/src/models/filter_tool/filter_tool_type.dart';
import 'package:snapcut/src/models/seed_image/seed_image.dart';

class IoSeedImage implements SeedImage {
  @override
  Uint8List? bytes;

  @override
  String? path;

  @override
  late List<FilterToolType> filterToolTypes;

  @override
  Widget get image {
    Widget img = Image.file(File(path!));

    for (var typeFilterTool in filterToolTypes) {
      for (var tool in typeFilterTool.filterToolList) {
        img = tool.filter(img);
      }
    }

    return img;
  }

  @override
  void openFile(data, List<FilterToolType> filterToolTypes) {
    path = data as String;
    this.filterToolTypes = filterToolTypes;
  }
}

SeedImage getPlatformSeedImage() => IoSeedImage();

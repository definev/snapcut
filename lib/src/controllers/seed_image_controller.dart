import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:snapseed/src/_internal/universal_picker/universal_picker.dart';
import 'package:snapseed/src/db/snapseed_db.dart';
import 'package:snapseed/src/models/filter_tool/.filter.dart';
import 'package:snapseed/src/models/filter_tool/filter_tool_type.dart';
import 'package:snapseed/src/models/filter_tool/tool_type.dart';
import 'package:snapseed/src/models/seed_image/seed_image.dart';

final seedImageControllerProvider = StateNotifierProvider<SeedImageController, SeedImage?>((ref) => SeedImageController());

class SeedImageController extends StateNotifier<SeedImage?> {
  SeedImageController() : super(null) {
    if (kIsWeb) return;
    var si = SnapseedDb.singleton.seedImage.seedImage;
    if (si != null && si.path != null) {
      if (io.File(si.path!).existsSync()) {
        state = si;
      } else {
        SnapseedDb.singleton.seedImage.seedImage = null;
      }
    }
  }

  void openImage() async {
    UniversalPicker universalPicker = UniversalPicker();
    await universalPicker.open();
    var si = SeedImage();
    List<FilterToolType> defaultFilter = [
      FilterToolType(
        ToolType.tune,
        [
          // ColorFilterTool('#FAFF421F', BlendMode.modulate),
          // ColorFilterTool('#AA00F2F3', BlendMode.modulate),
          MatrixFilterTool([
            [1, 0, 0, 0, 0],
            [0, 1, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 1, 0],
          ]),
        ],
      ),
    ];
    if (kIsWeb) {
      if (universalPicker.uint8list != null) {
        si.openFile(universalPicker.uint8list!, defaultFilter);

        state = si;
      }
    } else {
      if (universalPicker.path != null) {
        si.openFile(universalPicker.path!, defaultFilter);
        state = si;
        SnapseedDb.singleton.seedImage.seedImage = state;
      }
    }
  }
}
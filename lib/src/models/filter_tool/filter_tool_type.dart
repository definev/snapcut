import 'package:hive/hive.dart';
import 'package:snapcut/src/utils/db_id.dart';

import 'filter_tool.dart';
import 'tool_type.dart';

part 'filter_tool_type.g.dart';

@HiveType(typeId: HiveId.typeFilterTool)
class FilterToolType {
  @HiveField(0)
  final ToolType type;
  @HiveField(1)
  final List<FilterTool> filterToolList;

  const FilterToolType(this.type, this.filterToolList);
}

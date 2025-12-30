import 'package:pos_app/data/models/item_group.dart';
import 'package:pos_app/data/repositories/base_repository.dart';

class ItemGroupRepository extends BaseRepository<ItemGroupModel> {
  ItemGroupRepository() : super(endpoint: '/api/resource/Item Group');

  @override
  ItemGroupModel fromJson(Map<String, dynamic> json) {
    return ItemGroupModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(ItemGroupModel model) {
    return model.toJson();
  }
}

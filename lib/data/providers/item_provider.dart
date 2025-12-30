import 'package:pos_app/data/providers/base_provider.dart';

class ItemProvider extends BaseProvider {
  // - get()
  // - post()
  // - put()
  // - patch()
  // - delete()

  Future<Map<String, dynamic>> getItems({
    String? itemGroup,
    String? search,
    int? page,
    int? limit,
    String? orderBy,
  }) async {
    Map<String, dynamic> queryParams = {};
    
    if (itemGroup != null && itemGroup.isNotEmpty) {
      queryParams['item_group'] = itemGroup;
    }
     if (page != null) {
      queryParams['page'] = page;
    }
     if (limit != null) {
      queryParams['limit'] = limit;
    }
    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }
    
    if (limit != null) {
      queryParams['limit'] = limit;
    }

    if (orderBy != null && orderBy.isNotEmpty) {
      queryParams['order_by'] = orderBy;
    }
    
    return await get(
      '/api/method/mobile_haifa.flutter_apis.items.get_items',
      query: queryParams.isNotEmpty ? queryParams : null,
    );
  }
}

import 'package:pos_app/data/models/item.dart';
import 'package:pos_app/data/providers/item_provider.dart';
import 'package:pos_app/data/repositories/base_repository.dart';




class ItemRepository extends BaseRepository<ItemModel>{
    ItemRepository():super(endpoint:'/api/resource/Item',provider:ItemProvider());



    @override
    ItemModel fromJson(Map<String, dynamic> json) {
        return ItemModel.fromJson(json);
    }

    @override
    Map<String, dynamic> toJson(ItemModel model) {
        return model.toJson();
    }


   Future<Map<String, dynamic>> getItemsFromCustomAPI({
      String? itemGroup,
      String? search,
      int? page,
      int? limit,
      String? orderBy,
    }) async {
      try {
        final itemProvider = provider as ItemProvider;
        final response = await itemProvider.getItems(
          itemGroup: itemGroup,
          search: search,
          page: page,
          limit: limit,
          orderBy: orderBy,
        );
        
        print("📦 Full response: $response");
        
        // ✅ التحقق من success في response
        if (response['success'] == true) {
          print("✅ Response success");
          
          // ✅ استخراج البيانات من response['data']['message']['data']
          if (response['data'] != null && response['data'] is Map) {
            final dataMap = response['data'] as Map<String, dynamic>;
            print("📦 dataMap: $dataMap");
            
            if (dataMap.containsKey('message') && dataMap['message'] is Map) {
              final message = dataMap['message'] as Map<String, dynamic>;
              print("📦 message: $message");
              
              // ✅ التحقق من success في message
              if (message['success'] == true) {
                if (message.containsKey('data') && message['data'] is Map) {
                  final messageData = message['data'] as Map<String, dynamic>;
                  print("📦 messageData: $messageData");
                  
                  // ✅ استخراج items
                  List<ItemModel> items = [];
                  if (messageData.containsKey('items') && 
                      messageData['items'] is List) {
                    final itemsList = messageData['items'] as List;
                    print("✅ Found ${itemsList.length} items");
                    
                    items = itemsList
                        .map((json) => fromJson(Map<String, dynamic>.from(json)))
                        .toList();
                  }
                  
                  // ✅ استخراج pagination
                  Map<String, dynamic> pagination = {};
                  if (messageData.containsKey('pagination') && 
                      messageData['pagination'] is Map) {
                    pagination = Map<String, dynamic>.from(
                      messageData['pagination'] as Map
                    );
                    print("✅ Pagination: $pagination");
                  }
                  
                  return {
                    'items': items,
                    'pagination': pagination,
                  };
                }
              }
            }
          }
        }
        
        print("❌ No data found in response");
        return {
          'items': <ItemModel>[],
          'pagination': <String, dynamic>{},
        };
      } catch (e) {
        print("❌ Error in getItemsFromCustomAPI: $e");
        rethrow;
      }
    }
}
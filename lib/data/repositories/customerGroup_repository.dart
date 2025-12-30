import 'package:pos_app/data/models/customer_group.dart';
import 'package:pos_app/data/repositories/base_repository.dart';

class CustomerGroupRepository extends BaseRepository<CustomerGroupModel> {
  CustomerGroupRepository() : super(endpoint: '/api/resource/Customer Group');

  @override
  CustomerGroupModel fromJson(Map<String, dynamic> json) {
    return CustomerGroupModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(CustomerGroupModel model) {
    return model.toJson();
  }
}

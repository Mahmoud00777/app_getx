

class ItemGroupModel{
    final String name;
    final bool? is_group;
    final String? parent_item_group;


    ItemGroupModel({
        required this.name,
        this.is_group,
        this.parent_item_group,
    });

    factory ItemGroupModel.fromJson(Map<String, dynamic> json) {
        return ItemGroupModel(
            name: json['name'],
            is_group: json['is_group'],
            parent_item_group: json['parent_item_group'],
        );
    }

    Map<String, dynamic> toJson() {
        return {
            'name': name,
            'is_group': is_group,
            'parent_item_group': parent_item_group,
        };
    }

    ItemGroupModel copyWith({
        String? name,
        bool? is_group,
        String? parent_item_group,
    }) {
        return ItemGroupModel(
            name: name ?? this.name,
            is_group: is_group ?? this.is_group,
            parent_item_group: parent_item_group ?? this.parent_item_group,
        );
    }
}
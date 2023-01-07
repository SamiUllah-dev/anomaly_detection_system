import 'dart:convert';

class Face {
  String id;
  String name;
  String secureUrl;
  Face({
    required this.id,
    required this.name,
    required this.secureUrl,
  });

  Face copyWith({
    String? id,
    String? name,
    String? secureUrl,
  }) {
    return Face(
      id: id ?? this.id,
      name: name ?? this.name,
      secureUrl: secureUrl ?? this.secureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'secureUrl': secureUrl});

    return result;
  }

  factory Face.fromMap(Map<String, dynamic> map) {
    return Face(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      secureUrl: map['secureUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Face.fromJson(String source) => Face.fromMap(json.decode(source));

  @override
  String toString() => 'Face(id: $id, name: $name, secureUrl: $secureUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Face &&
        other.id == id &&
        other.name == name &&
        other.secureUrl == secureUrl;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ secureUrl.hashCode;
}

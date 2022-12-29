import 'dart:convert';

class Person {
  final String id;
  final String name;
  final String phoneNumber;
  Person({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  Person copyWith({
    String? id,
    String? name,
    String? phoneNumber,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'phoneNumber': phoneNumber});

    return result;
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() =>
      'Person(id: $id, name: $name, phoneNumber: $phoneNumber)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ phoneNumber.hashCode;
}

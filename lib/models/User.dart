class User {
  int? id;
  String? name;
  String? contact;
  String? address;

  Usermap() {
    var mapping = Map<String, dynamic>();

    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['contact'] = contact!;
    mapping['address'] = address!;

    return mapping;
  }
}

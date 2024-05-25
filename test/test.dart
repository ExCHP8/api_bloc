typedef JSON = Map<String, dynamic>;

class TestModel {
  const TestModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  JSON get toJSON {
    return {
      'id': id,
      'name': name,
    };
  }

  factory TestModel.fromJSON(JSON value) {
    return TestModel(
      id: value['id'] ?? 0,
      name: value['name'] ?? 'No Name',
    );
  }

  factory TestModel.test() {
    return const TestModel(
      id: 6,
      name: 'Bob the Builder',
    );
  }
}

class ApprovedAppoinmentModel {
  final String id;
  final String name;
  final String relation;
  final int age;
  final String gender;
  final String status;
  final String type;
  final String hospital;
  final String department;
  final String date;

  ApprovedAppoinmentModel({
    required this.id,
    required this.name,
    required this.relation,
    required this.age,
    required this.gender,
    required this.status,
    required this.type,
    required this.hospital,
    required this.department,
    required this.date,
  });

  // Factory method to create ApprovedAppoinmentModel from JSON
  factory ApprovedAppoinmentModel.fromJson(Map<String, dynamic> json) {
    return ApprovedAppoinmentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      relation: json['relation'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      hospital: json['hospital'] ?? '',
      department: json['department'] ?? '',
      date: json['date'] ?? '',
    );
  }

  // Method to convert ApprovedAppoinmentModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'relation': relation,
      'age': age,
      'gender': gender,
      'status': status,
      'type': type,
      'hospital': hospital,
      'department': department,
      'date': date,
    };
  }
}

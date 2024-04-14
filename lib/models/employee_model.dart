class EmployeeModel {
  final String name;
  final String phone;
  final String address;
  final String salary;
  final String position;
  final String id;
  final int reminingSalary;
  final String agentId;

  EmployeeModel(
      {required this.reminingSalary,
      required this.name,
      required this.phone,
      required this.address,
      required this.salary,
      required this.position,
      required this.id,
      required this.agentId});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      salary: json['salary'],
      position: json['position'],
      id: json['id'],
      reminingSalary: json['remining_salary'],
      agentId: json['agent_id'],
    );
  }
}

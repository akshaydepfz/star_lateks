class StockBarrel {
  final String id;
  final String advancePaid;
  final String customerName;
  final String customerId;
  final String totalWeight;
  final String date;

  StockBarrel(
      {required this.id,
      required this.advancePaid,
      required this.customerName,
      required this.customerId,
      required this.totalWeight,
      required this.date});

  factory StockBarrel.fromJson(Map<String, dynamic> json) {
    return StockBarrel(
        id: json['id'] ?? "",
        advancePaid: json['advance_paid'] ?? '',
        customerName: json['customerName'],
        customerId: json['customer_id'],
        totalWeight: json['totalWeight'],
        date: json['date']);
  }
}

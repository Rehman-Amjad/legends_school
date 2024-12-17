
class DailyExpenseModel {
  final String timeStamp;
  final double amount;
  final String description;
  final String category;
  final String paymentMethod;
  final String monthYear;

  DailyExpenseModel({
    required this.timeStamp,
    required this.amount,
    required this.description,
    required this.category,
    required this.paymentMethod,
    required this.monthYear,
  });

  Map<String, dynamic> toMap() {
    return {
      'timeStamp': timeStamp,
      'amount': amount,
      'description': description,
      'category': category,
      'paymentMethod': paymentMethod,
      'monthYear': monthYear,
    };
  }

  factory DailyExpenseModel.fromMap(Map<String, dynamic> map) {
    return DailyExpenseModel(
      timeStamp: map['timeStamp'] ?? "",
      amount: map['amount'] ?? 0.0,
      description: map['description'] ?? "",
      category: map['category'] ?? "",
      paymentMethod: map['paymentMethod'] ?? "",
      monthYear: map['monthYear'] ?? "",
    );
  }
}
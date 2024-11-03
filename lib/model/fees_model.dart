// models/fee_model.dart
class FeeModel {
  final String feeId;
  final String studentId;
  final String billingCycle;
  final DateTime dueDate;
  final double amountDue;
  final double amountPaid;
  final String paymentStatus;
  final String timeStamp;
  final List<Map<String, dynamic>> paymentHistory;

  FeeModel({
    required this.feeId,
    required this.studentId,
    required this.billingCycle,
    required this.dueDate,
    required this.amountDue,
    required this.amountPaid,
    required this.paymentStatus,
    required this.timeStamp,
    required this.paymentHistory,
  });

  // Factory method to create an instance from Firestore document data
  factory FeeModel.fromDocument(Map<String, dynamic> doc, String docId) {
    return FeeModel(
      feeId: docId,
      studentId: doc['studentId'] ?? '',
      billingCycle: doc['billingCycle'] ?? '',
      dueDate: DateTime.parse(doc['dueDate']),
      amountDue: doc['amountDue']?.toDouble() ?? 0.0,
      amountPaid: doc['amountPaid']?.toDouble() ?? 0.0,
      paymentStatus: doc['paymentStatus'] ?? 'Unpaid',
      timeStamp: doc['timeStamp'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      paymentHistory: List<Map<String, dynamic>>.from(doc['paymentHistory'] ?? []),
    );
  }
}

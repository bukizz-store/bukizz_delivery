import 'package:cloud_firestore/cloud_firestore.dart';
import '../address/orderAddress.dart';

class OrderModel{
  String orderId;
  String userId;
  String orderDate;
  String orderName;
  double totalAmount;
  double saleAmount;
  int deliveryCharge;
  OrderAddress address;
  Map<String , dynamic> cartData;
  int cartLength;
  String status;
  String reviewId;
  String retailerId;
  String transactionId;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.orderDate,
    required this.orderName,
    required this.totalAmount,
    required this.saleAmount,
    required this.deliveryCharge,
    required this.address,
    required this.cartData,
    required this.cartLength,
    required this.status,
    required this.reviewId,
    required this.retailerId,
    required this.transactionId,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'orderDate': orderDate,
      'orderName': orderName,
      'totalAmount': totalAmount,
      'saleAmount': saleAmount,
      'deliveryCharge': deliveryCharge,
      'address': address.toMap(),
      'cartData': cartData,
      'cartLength': cartLength,
      'status': status,
      'reviewId': reviewId,
      'retailerId': retailerId,
      'transactionId': transactionId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
      orderDate: map['orderDate'] ?? '',
      orderName: map['orderName'] ?? '',
      totalAmount: map['totalAmount'] ?? 0.0,
      saleAmount: map['saleAmount'] ?? 0.0,
      deliveryCharge: map['deliveryCharge'] ?? 0,
      address: OrderAddress.fromMap(map['address']),
      cartData: map['cartData'],
      cartLength: map['cartLength'] ?? 0,
      status: map['status'] ?? '',
      reviewId: map['reviewId'] ?? '',
      retailerId: map['retailerId'] ?? '',
      transactionId: map['transactionId'] ?? '',
    );
  }

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      orderId: data['orderId'] ?? '',
      userId: data['userId'] ?? '',
      orderDate: data['orderDate'] ?? '',
      orderName: data['orderName'] ?? '',
      totalAmount: data['totalAmount'] ?? 0.0,
      saleAmount: data['saleAmount'] ?? 0.0,
      deliveryCharge: data['deliveryCharge'] ?? 0,
      address: OrderAddress.fromMap(data['address']),
      cartData: data['cartData'],
      cartLength: data['cartLength'] ?? 0,
      status: data['status'] ?? '',
      reviewId: data['reviewId'] ?? '',
      retailerId: data['retailerId'] ?? '',
      transactionId: data['transactionId'] ?? '',
    );
  }
}
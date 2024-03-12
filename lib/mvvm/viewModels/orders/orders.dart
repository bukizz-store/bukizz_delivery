import 'package:bukizz_delivery/constants/strings.dart';
import 'package:bukizz_delivery/mvvm/models/product/product.dart';
import 'package:bukizz_delivery/mvvm/viewModels/Product/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/constants.dart';
import '../../models/notifications/notifications.dart';
import '../../models/orders/orders.dart';

class Orders extends ChangeNotifier {
  Orders() {
    _fetchPendingOrders();
    _fetchDeliveredOrders();
  }

  List<OrderModel> pendingOrders = [];
  List<OrderModel> deliveredOrders = [];
  String listAddress = '';

  Future<void> _fetchPendingOrders() async {
    try {
      FirebaseFirestore.instance
          .collection(AppString.collectionDelivery)
          .doc(AppConstants.userData.id)
          .snapshots()
          .listen((snapshot) {
        print("Run");
        pendingOrders.clear();
        listAddress = '';
        for (var doc in snapshot.data()!['pendingDelivery']) {
          print(doc);
          FirebaseFirestore.instance
              .collection('orderDetails')
              .doc(doc)
              .snapshots()
              .listen((snapshotData) {
            OrderModel orderModel = OrderModel.fromMap(snapshotData.data()!);
            listAddress += orderModel.address.toNavigateString();
            pendingOrders.add(orderModel);
            listAddress += '/';
          });
        }
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _fetchDeliveredOrders() async {
    try {
      FirebaseFirestore.instance
          .collection(AppString.collectionDelivery)
          .doc(AppConstants.userData.id)
          .snapshots()
          .listen((snapshot) {
        deliveredOrders.clear();
        for (var doc in snapshot.data()!['delivered']) {
          FirebaseFirestore.instance
              .collection('orderDetails')
              .doc(doc)
              .snapshots()
              .listen((snapshot) {
            deliveredOrders.add(OrderModel.fromMap(snapshot.data()!));
            notifyListeners();
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  bool isOrderStatusUpdated = false;

  bool get orderStatusUpdated => isOrderStatusUpdated;

  set orderStatusUpdated(bool value) {
    isOrderStatusUpdated = value;
    notifyListeners();
  }

  Future<void> updateOrderStatus(OrderModel orders, String status) async {
    // try {
    //   orderStatusUpdated = true;
      late String productId;
      late String schoolName;
      late String set;
      late String stream;
      String orderId = orders.orderId;
      String userId = orders.userId;
      Map<String, Map<String, Map<String, Map<String, List<dynamic>>>>>
          productsIdMap = {};
      orders.cartData.forEach((school, schoolData) {
        productsIdMap[school] = {};
        schoolData.forEach((product, productData) {
          productsIdMap[school]![product] = {};
          productData.forEach((key1, innerMap) {
            productsIdMap[school]![product]![key1] = {};
            innerMap.forEach((key2, value) {
              productsIdMap[school]![product]![key1]![key2] = value;
              productId = product;
              schoolName = school;
              set = key1;
              stream = key2;
            });
          });
        });
      });
      ProductModel productModel = await Product().fetchProduct(productId);

      switch (status) {
        case "Delivered":
          {
            print(set + stream + productModel.variation.toString());
            NotificationModel notificationModel = NotificationModel(
              navInit: 'Your Order is',
              navLast: 'Delivered',
              content: 'Your product ${productModel.name} $set ${stream != '0' ? stream : ''} - $schoolName is delivered',
              image: productModel
                  .variation[productModel.set
                      .indexWhere((element) => element.name == set)
                      .toString()]![stream != "" ? productModel.stream
                  .indexWhere((element) => element.name == stream)
                  .toString() : stream.toString()]!
                  .image[0],
              date: DateTime.now().toIso8601String(),
              notificationId: '1',
              link: '/order/$orderId',
            );
            await sendNotification(notificationModel, userId);
          }
        case "Redelivery":
          {
            NotificationModel notificationModelRedelivery = NotificationModel(
              navInit: 'Your Order is',
              navLast: 'in Redelivery',
              content:
                  'Your product ${productModel.name} $set ${stream != '0' ? stream : ''} - $schoolName is in Redelivery',
              image:
                  'https://firebasestorage.googleapis.com/v0/b/bukizz1.appspot.com/o/product_image%2Fbooks%2FBSCL10.png?alt=media&token=b94b7399-ece5-4382-9f7c-3c5023ed944d',
              date: DateTime.now().toIso8601String(),
              notificationId: '1',
              link: '/order/$orderId',
            );

            await sendNotification(notificationModelRedelivery, userId);
          }
      }

      (status != 'Redelivery')
          ? await FirebaseFirestore.instance
              .collection('orderDetails')
              .doc(orderId)
              .update({'status': status}).then((value) => FirebaseFirestore
                      .instance
                      .collection(AppString.collectionDelivery)
                      .doc(AppConstants.userData.id)
                      .update({
                    'pendingDelivery': FieldValue.arrayRemove([orderId]),
                    'delivered': FieldValue.arrayUnion([orderId])
                  }))
          : await FirebaseFirestore.instance
              .collection('orderDetails')
              .doc(orderId)
              .update({'status': status}).then((value) => FirebaseFirestore
                      .instance
                      .collection(AppString.collectionDelivery)
                      .doc(AppConstants.userData.id)
                      .update({
                    'pendingDelivery': FieldValue.arrayRemove([orderId]),
                  }));
    // } catch (e) {
    //   print(e);
    // }
    // orderStatusUpdated = false;
  }

  Future<void> sendNotification(
      NotificationModel notificationModel, String userId) async {
    await FirebaseDatabase.instance
        .ref()
        .child('notifications')
        .child(userId)
        .push()
        .set(notificationModel.toMap());
  }
}

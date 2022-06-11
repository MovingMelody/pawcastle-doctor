import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/constants/keys.dart';
import 'package:petdoctor/constants/strings.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

const List<String> kOrderStatus = [
  'paid',
  'ready',
  'driver_assigned',
  'dispatched'
];

class FirestoreApi {
  final _log = getLogger('FirestoreApi');

  final _geoFlutterFire = Geoflutterfire();

  final _doctorsRef =
      FirebaseFirestore.instance.collection(kDoctors).withConverter<Doctor>(
            fromFirestore: (snapshot, _) => Doctor.fromSnapshot(snapshot),
            toFirestore: (doctor, _) => doctor.toMap(),
          );

  final _treatmentsRef = FirebaseFirestore.instance
      .collection(kTreatments)
      .withConverter<Treatment>(
        fromFirestore: (snapshot, _) => Treatment.fromSnapshot(snapshot),
        toFirestore: (treatment, _) => treatment.toMap(),
      );

  final _treatmentDiagnosisRef = FirebaseFirestore.instance
      .collection(kTreatmentDiagnosis)
      .withConverter<TreatmentDiagnosis>(
        fromFirestore: (snapshot, _) =>
            TreatmentDiagnosis.fromMap(snapshot.data()!),
        toFirestore: (treatment, _) => treatment.toMap(),
      );

  final _medicineOrderRef = FirebaseFirestore.instance
      .collection(kMedicineOrders)
      .withConverter<MedicineOrder>(
        fromFirestore: (snapshot, _) => MedicineOrder.fromSnapshot(snapshot),
        toFirestore: (treatment, _) => treatment.toMap(),
      );

  final StreamController<List<MedicineOrder>> _medicineOrdersStream =
      StreamController<List<MedicineOrder>>.broadcast();

  Stream getDoctorOrders({required String userId}) {
    _fetchUserOrders(userId);
    return _medicineOrdersStream.stream;
  }

  void _fetchUserOrders(String userId) {
    _medicineOrderRef
        .where("status", whereIn: kOrderStatus)
        .where("doctor.id", isEqualTo: userId)
        .snapshots()
        .listen((ordersSnapshot) {
      if (ordersSnapshot.docs.isEmpty) {
        _log.i("No orders found to this pharmacy");
      } else if (ordersSnapshot.docs.isNotEmpty) {
        var orders =
            ordersSnapshot.docs.map((snapshot) => snapshot.data()).toList();
        _medicineOrdersStream.add(orders);
      }
    });
  }

  /// Creates a new Doctor document with [doctorId] as documentId
  /// and inside the [kDoctorsFirestoreKey] collection
  Future<void> createDoctor({required Doctor doctor}) async {
    try {
      final doctorDoc = _doctorsRef.doc(doctor.id);
      await doctorDoc.set(doctor);
      _log.v('Doctor created at ${doctorDoc.path}');
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new Doctor',
        devDetails: '$error',
      );
    }
  }

  Future<void> createDiagnosis({required TreatmentDiagnosis diagnosis}) async {
    try {
      final doctorDoc = _treatmentDiagnosisRef.doc(diagnosis.id);
      await doctorDoc.set(diagnosis);
      _log.v('Diagnosis created at ${doctorDoc.path}');
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new Doctor',
        devDetails: '$error',
      );
    }
  }

  /// Reads Doctor from Firestore
  Future<Doctor?> getDoctor(String doctorId) async {
    final doctorDoc = await _doctorsRef.doc(doctorId).get();

    if (!doctorDoc.exists) {
      _log.v('We have no user with id $doctorId in our database');
      return null;
    }

    final userData = doctorDoc.data();
    _log.v('User found. Data: $userData');

    return userData!.copyWith(reference: doctorDoc.reference);
  }

  Future<TreatmentDiagnosis?> getTreatmentDiagnosis(String doctorId) async {
    final doctorDoc = await _treatmentDiagnosisRef.doc(doctorId).get();

    if (!doctorDoc.exists) {
      _log.v('We have no user with id $doctorId in our database');
      return null;
    }

    final userData = doctorDoc.data();
    _log.v('User found. Data: $userData');

    return userData;
  }

  Future getTreatment(String caseId) async {
    try {
      var treatmentDocumentSnapshot = await _treatmentsRef.doc(caseId).get();

      return treatmentDocumentSnapshot
          .data()
          ?.copyWith(reference: treatmentDocumentSnapshot.reference);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  // read the treatments related to current doctor
  Future fetchTreatments(String doctorId) async {
    try {
      var query = _treatmentsRef.where('doctor.id', isEqualTo: doctorId);
      query = query.orderBy('timestamp', descending: true);
      query = query.limit(10);

      var treatmentDocumentSnapshot = await query.get();

      if (treatmentDocumentSnapshot.docs.isNotEmpty) {
        return treatmentDocumentSnapshot.docs
            .map((snapshot) => snapshot.data())
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future<void> createMedicineOrder({required MedicineOrder order}) async {
    try {
      final orderDoc = _medicineOrderRef.doc(order.id);
      await orderDoc.set(order);
      _log.v('Order created at ${orderDoc.path}');
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new Doctor',
        devDetails: '$error',
      );
    }
  }

  updateToken(String id, String token) async =>
      await _doctorsRef.doc(id).update({"fcmToken": token});
}

class FirestoreApiException implements Exception {
  final String message;
  final String? devDetails;
  final String? prettyDetails;

  FirestoreApiException({
    required this.message,
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'FirestoreApiException: $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}

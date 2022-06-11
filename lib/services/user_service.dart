import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/api/firestore.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/firestore/fcm.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';

class UserService {
  final _firebaseAuthApi = locator<FirebaseAuthApi>();
  final _firestoreApi = locator<FirestoreApi>();
  final _fcmService = locator<FcmService>();
  final _log = getLogger("UserService");

  

  final _bankAccountsCollection = FirebaseFirestore.instance
      .collection(kBankAccounts)
      .withConverter<BankAccount>(
        fromFirestore: (snapshot, _) => BankAccount.fromMap(snapshot.data()!),
        toFirestore: (pharmacy, _) => pharmacy.toMap(),
      );

  

  Doctor? _currentUser;

  Doctor get currentUser => _currentUser!;

  bool get hasLoggedInUser => _firebaseAuthApi.hasAuthUser;

  bool get hasProfile => _currentUser != null;

  Future<void> syncUserAccount() async {
    var doctorId = _firebaseAuthApi.authUser!.uid;

    _log.v("Syncing user $doctorId");

    final userAccount = await _firestoreApi.getDoctor(doctorId);

    if (userAccount != null) {
      _log.v('User account exists. Save as _currentUser');
      _currentUser = userAccount;
      updateToken();
    }
  }

  Future updateToken() async {
    var updatedToken = await _fcmService.getUpdatedToken(currentUser.fcmToken);

    if (updatedToken != null) {
      await _firestoreApi.updateToken(currentUser.id, updatedToken);
    }
  }

  Future<void> createAndSyncUserAccount({required Doctor doctor}) async {
    _log.i('Create a new doctor with ${doctor.id}');

    var token = await _fcmService.generateToken();

    await _firestoreApi.createDoctor(doctor: doctor.copyWith(fcmToken: token));

    _currentUser = doctor;
    _log.v('_currentUser has been saved');
  }

  updateStatus(bool status) async {
    _log.i('Changing doctor status to $status');

    await currentUser.reference?.update({'online': status}).then(
        (value) => _currentUser = currentUser.copyWith(online: status));
  }

  

  

  Future<BankAccount?> getBankAccountDetails() async {
    try {
      var doctorId = currentUser.id;
      final accountDoc = await _bankAccountsCollection.doc(doctorId).get();
      if (!accountDoc.exists) {
        _log.v('No bank details doc found to this user');
        return null;
      }

      final userData = accountDoc.data();
      _log.v('User found. Data: $userData');

      return userData;
    } catch (error) {
      throw FirestoreApiException(
          message: 'Failed to get bank account details', devDetails: '$error');
    }
  }

  Future<void> addBankAccountDetails(BankAccount bankAccount) async {
    await _bankAccountsCollection
        .doc(bankAccount.id)
        .set(bankAccount.copyWith(contactId: currentUser.razorpayId));

    _log.i("Bank account added to ${currentUser.id}");
  }
}

class NoBankAccountException implements Exception {
  @override
  String toString() {
    return 'NoBankAccountException: User has no active bank accounts';
  }
}

class NoMoneyException implements Exception {
  @override
  String toString() {
    return 'NoMoneyException: User has no money';
  }
}

class PayoutFailedException implements Exception {
  @override
  String toString() {
    return 'PayoutFailedException: User has no money';
  }
}

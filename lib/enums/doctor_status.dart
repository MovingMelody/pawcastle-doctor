enum DoctorStatus {
  //
  Online,
  // when doctor is not available to accept orders
  Offline,
  // when doctor is on another call
  Busy
}

extension DoctorStatusExtension on DoctorStatus {
  String get status {
    switch (this) {
      case DoctorStatus.Offline:
        return 'offline';
      case DoctorStatus.Busy:
        return 'busy';
      case DoctorStatus.Online:
        return 'online';
      default:
        return '';
    }
  }
}

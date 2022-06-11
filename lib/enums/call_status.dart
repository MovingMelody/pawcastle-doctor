enum CallStatus {
  /// the call starts with this state
  /// when patient calls doctor
  Dial,

  /// when doctor lifts the call from patient
  Lift,

  /// when both patient and doctor joins the room
  Connect,

  /// when the treatment is completed, we disconnects the call
  End,

  /// when patient disconnects the call before doctor joins
  Cancel
}

extension CallExtension on CallStatus {
  String get status {
    switch (this) {
      case CallStatus.Dial:
        return 'dial';
      case CallStatus.Lift:
        return 'lift';
      case CallStatus.Connect:
        return 'connect';
      case CallStatus.End:
        return 'end';
      default:
        return 'cancel';
    }
  }
}

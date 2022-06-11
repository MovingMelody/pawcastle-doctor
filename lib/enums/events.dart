enum LogEvents {
  // PhoneAuth Verification Success
  LoginSuccess,

  // PhoneAuth Error
  LoginFailed,

  // Signed up for Profile
  ProfileSignup,

  // Accepts call from patient
  CallAccept,

  // Treated Patient Successfully
  TreatmentDone
}

extension Stringify on LogEvents {
  String get event {
    switch (this) {
      case LogEvents.TreatmentDone:
        return 'doc_treatment_done';
      case LogEvents.CallAccept:
        return 'doc_call_accept';
      case LogEvents.LoginFailed:
        return 'doc_login_failed';
      case LogEvents.LoginSuccess:
        return 'doc_login_success';
      case LogEvents.ProfileSignup:
        return 'doc_profile_signup';
      default:
        return '';
    }
  }
}

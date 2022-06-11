import 'package:petdoctor/api/firestore.dart';
import 'package:petdoctor/firestore/remote_config.dart';
import 'package:petdoctor/services/api_service.dart';
import 'package:petdoctor/services/call_service.dart';
import 'package:petdoctor/services/cloud_storage_service.dart';
import 'package:petdoctor/services/environment_service.dart';
import 'package:petdoctor/firestore/fcm.dart';
import 'package:petdoctor/services/medicine_service.dart';
import 'package:petdoctor/services/notification_service.dart';
import 'package:petdoctor/services/ringtone_service.dart';
import 'package:petdoctor/services/update_service.dart';
import 'package:petdoctor/services/url_service.dart';
import 'package:petdoctor/services/user_service.dart';
import 'package:petdoctor/ui/create_profile/create_profile_view.dart';
import 'package:petdoctor/ui/diagnosis/diagnosis_view.dart';
import 'package:petdoctor/ui/diagnosis/global_medicines_view.dart';
import 'package:petdoctor/ui/fetch_pharmacies/services/selected_medicines_store.dart';
import 'package:petdoctor/ui/login/login_view.dart';
import 'package:petdoctor/ui/main/main_view.dart';
import 'package:petdoctor/ui/onboarding/onboarding_view.dart';
import 'package:petdoctor/ui/pending_approval/pending_approval.dart';
import 'package:petdoctor/ui/pickup/pickup_view.dart';
import 'package:petdoctor/ui/profile/profile_view.dart';
import 'package:petdoctor/ui/startup/startup_view.dart';
import 'package:petdoctor/ui/verify_phone/verify_phone_view.dart';
import 'package:petdoctor/ui/view_treatment/treatment_details_view.dart';
import 'package:petdoctor/utils/image_picker.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'injection.dart';
import 'package:http/http.dart';

/// Note: Run the following command after making changes
/// flutter pub run build_runner build --delete-conflicting-outputs
@StackedApp(
  routes: [
    /// All your application routes needs to be injected here
    /// Two default routes available -
    /// #1. MaterialRoute(page: StartUpView, initial: true),
    /// #2. CupertinoRoute(page: HomeView),
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: PickupView),
    MaterialRoute(page: CreateProfileView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: VerifyPhoneView),
    MaterialRoute(page: OnboardingView),
    MaterialRoute(page: TreatmentDetailsView),
    MaterialRoute(page: DiagnosisView),
    MaterialRoute(page: MainView),
    MaterialRoute(page: PendingApproval),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: GlobalMedicinesView),
  ],
  dependencies: [
    /// Inject your dependencies here
    /// For Singletons - Singleton(classType: NavigationService),
    /// For LazySingleton (i.e the object will not be created until its called)
    /// LazySingleton(classType: NavigationService),
    Presolve(
      classType: EnvironmentService,
      presolveUsing: EnvironmentService.getInstance,
    ),
    Presolve(
      classType: SupabaseInjection,
      presolveUsing: SupabaseInjection.getSupabase,
    ),
    Presolve(
      classType: PackageInjection,
      presolveUsing: PackageInjection.getInstance,
    ),
    LazySingleton(classType: UpdateService),
    Presolve(
        classType: RtcInjection, presolveUsing: RtcInjection.getAgoraEngine),

    // Stacked services
    LazySingleton(classType: NotificationService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),

    // Custom services
    LazySingleton(classType: ImageSelector),
    LazySingleton(classType: OpenLinkService),
    LazySingleton(classType: RemoteConfigService),
    // LazySingleton(classType: AnalyticsService),
    LazySingleton(classType: RingtoneService),
    LazySingleton(classType: FirebaseAuthApi),
    LazySingleton(classType: FirestoreApi),
    LazySingleton(classType: CloudStorageService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: CallService),
    LazySingleton(classType: FcmService),
    LazySingleton(classType: MedicineService),
    LazySingleton(classType: SelectedMedicinesStore),

    LazySingleton(classType: APIService),
    LazySingleton(classType: Client),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}

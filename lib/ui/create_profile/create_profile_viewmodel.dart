import 'dart:io';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:petdoctor/app/app.locator.dart';
import 'package:petdoctor/app/app.logger.dart';
import 'package:petdoctor/app/app.router.dart';
import 'package:petdoctor/constants/keys.dart';
import 'package:petdoctor/constants/strings.dart' as konstants;
import 'package:petdoctor/services/cloud_storage_service.dart';
import 'package:petdoctor/services/user_service.dart';
import 'package:petdoctor/utils/image_picker.dart';
import 'package:petdoctor/utils/popup_mixin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateProfileViewModel extends FormViewModel with OpenHelpMixin {
  final _imagePicker = locator<ImageSelector>();
  final _cloudStorage = locator<CloudStorageService>();
  final _userService = locator<UserService>();
  final _firebaseAuthApi = locator<FirebaseAuthApi>();
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _log = getLogger("DoctorProfile");

  int currentIndex = 0;
  String userId = '';
  String? approvalCommentByAdmin;
  String selectedSpec = "Animal Nutrition";

  List<String> selectedAnimals = ["Cat", "Dog", "Birds"];
  List<String> selectedLanguages = [];

  onModelReady() {
    userId = _firebaseAuthApi.authUser?.uid ?? '';

    if (_userService.hasProfile) {
      approvalCommentByAdmin = _userService.currentUser.profile.about;
    }

    notifyListeners();
  }

  // Files to store the required images
  File? profileImage, bvscCertificate, mvscCertificate, vciLicense;

  void next() {
    // #1. Name and Profile should not be null
    if (currentIndex == 0) {
      if ((!hasName || nameValue!.isEmpty) ||
          (selectedLanguages.length == 0) ||
          profileImage == null) {
        _log.v("Name/Email should not be null");
        _snackbarService.showSnackbar(
          message: konstants.kGenericErrorMessage,
          title: konstants.kDefaultErrorTitle,
        );

        return;
      }

      _log.v("Selected Name: $nameValue ");
    }

    // #2. The passed out year and bvsc certificate is must
    if (currentIndex == 1) {
      if ((!hasBvsc || bvscValue!.toString().trim().isEmpty) ||
          bvscCertificate == null) {
        _log.v("BVSc details should not be null");
        _snackbarService.showSnackbar(
          message: konstants.kGenericErrorMessage,
          title: konstants.kDefaultErrorTitle,
        );
        return;
      }

      _log.v("Selected Year: $bvscValue ");
    }

    if (currentIndex == 2) {
      if (vciLicense == null ||
          selectedAnimals.length == 0 ||
          selectedSpec == "Please select your species specialization") {
        _snackbarService.showSnackbar(
          message: konstants.kGenericErrorMessage,
          title: konstants.kDefaultErrorTitle,
        );
        _log.v("Please add your VCI license and specialization.");
        return;
      }

      _log.v("Selected animals: $selectedAnimals spec: $selectedSpec");

      createDoctor();
    }

    currentIndex = currentIndex == 2 ? currentIndex : currentIndex + 1;
    notifyListeners();
  }

  void previous() {
    currentIndex = currentIndex == 0 ? currentIndex : currentIndex - 1;
    notifyListeners();
  }

  _selectFile(String fileName) async {
    var pickedFile = await _imagePicker.selectImage();
    if (pickedFile != null)
      switch (fileName) {
        case 'bvsc':
          bvscCertificate = File(pickedFile.path);
          break;
        case 'vci':
          vciLicense = File(pickedFile.path);
          break;
        case 'mvsc':
          mvscCertificate = File(pickedFile.path);
          break;
        default:
          profileImage = File(pickedFile.path);
      }

    notifyListeners();
  }

  selectProfile() async => await _selectFile('image');
  selectBvsc() async => await _selectFile('bvsc');
  selectMvsc() async => await _selectFile('mvsc');
  selectVci() async => await _selectFile('vci');

  onAnimalSelected(String animal) {
    selectedAnimals.contains(animal)
        ? selectedAnimals.remove(animal)
        : selectedAnimals.add(animal);

    notifyListeners();
  }

  onLanguageSelected(String lang) {
    selectedLanguages.contains(lang)
        ? selectedLanguages.remove(lang)
        : selectedLanguages.add(lang);

    notifyListeners();
  }

  onSpecSelected(String spec) {
    selectedSpec = spec;
    notifyListeners();
  }

  createDoctor() async {
    setBusy(true);

    var profileUrl =
        await _cloudStorage.uploadFile(profileImage!, userId: userId);
    var bvscUrl =
        await _cloudStorage.uploadFile(bvscCertificate!, userId: userId);
    var mvscUrl = mvscCertificate == null
        ? ""
        : await _cloudStorage.uploadFile(mvscCertificate!, userId: userId);

    var vciUrl = await _cloudStorage.uploadFile(vciLicense!, userId: userId);

    var currentUser = _firebaseAuthApi.authUser;

    var doctor = Doctor(
        id: currentUser!.uid,
        name: nameValue!,
        phone: currentUser.phoneNumber!,
        image: profileUrl,
        online: false,
        verified: VerificationStatus.review,
        profile: DoctorProfile(
          bvsc: FileDocument(url: bvscUrl, data: bvscValue),
          mvsc: FileDocument(url: mvscUrl, data: mvscValue),
          license: FileDocument(url: vciUrl, data: bvscValue),
          species: selectedAnimals,
          designation: selectedSpec,
          about: '',
          languages: selectedLanguages,
        ));

    await _userService.createAndSyncUserAccount(doctor: doctor);

    setBusy(false);
    // as user creates his profile, he has to be approved by admin to accept cases
    Fluttertoast.showToast(msg: "Account created succesfully");
    _navigationService.replaceWith(Routes.pendingApproval);
  }

  @override
  void setFormStatus() {}
}

extension ValueProperties on FormViewModel {
  String? get nameValue => this.formValueMap[kProfileFormName];
  String? get emailValue => this.formValueMap[kProfileFormEmail];
  String? get mvscValue => this.formValueMap[kProfileFormMvsc];
  String? get bvscValue => this.formValueMap[kProfileFormBvsc];

  bool get hasName => this.formValueMap.containsKey(kProfileFormName);
  bool get hasEmail => this.formValueMap.containsKey(kProfileFormEmail);
  bool get hasMvsc => this.formValueMap.containsKey(kProfileFormMvsc);
  bool get hasBvsc => this.formValueMap.containsKey(kProfileFormBvsc);
}

extension Methods on FormViewModel {}

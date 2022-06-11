import 'package:petdoctor/constants/assets.dart';

mixin DynamicAssets {
  String getAsset(String animalType) {
    switch (animalType) {
      case "cattle":
        return cowPng;
      case "buffalo":
        return buffaloPng;
      case "sheep":
        return sheepPng;
      case "goat":
        return goatPng;
      case "dogs":
        return dogPng;
      case "cats":
        return catPng;
      case "poultry":
        return poultryPng;
      case "birds":
        return birdsPng;
      case "others":
        return exoticPng;
      default:
        return cowPng;
    }
  }
}

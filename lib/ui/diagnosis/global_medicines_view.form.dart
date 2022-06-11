// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs,  constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String SearchValueKey = 'search';

final Map<String, TextEditingController>
    _GlobalMedicinesViewTextEditingControllers = {};

final Map<String, FocusNode> _GlobalMedicinesViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _GlobalMedicinesViewTextValidations = {
  SearchValueKey: null,
};

mixin $GlobalMedicinesView on StatelessWidget {
  TextEditingController get searchController =>
      _getFormTextEditingController(SearchValueKey);
  FocusNode get searchFocusNode => _getFormFocusNode(SearchValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_GlobalMedicinesViewTextEditingControllers.containsKey(key)) {
      return _GlobalMedicinesViewTextEditingControllers[key]!;
    }
    _GlobalMedicinesViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _GlobalMedicinesViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_GlobalMedicinesViewFocusNodes.containsKey(key)) {
      return _GlobalMedicinesViewFocusNodes[key]!;
    }
    _GlobalMedicinesViewFocusNodes[key] = FocusNode();
    return _GlobalMedicinesViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    searchController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) {
    model.setData(
      model.formValueMap
        ..addAll({
          SearchValueKey: searchController.text,
        }),
    );
    _updateValidationData(model);
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        SearchValueKey: _getValidationMessage(SearchValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _GlobalMedicinesViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_GlobalMedicinesViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _GlobalMedicinesViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _GlobalMedicinesViewFocusNodes.values) {
      focusNode.dispose();
    }

    _GlobalMedicinesViewTextEditingControllers.clear();
    _GlobalMedicinesViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  String? get searchValue => this.formValueMap[SearchValueKey] as String?;

  bool get hasSearch => this.formValueMap.containsKey(SearchValueKey);

  bool get hasSearchValidationMessage =>
      this.fieldsValidationMessages[SearchValueKey]?.isNotEmpty ?? false;

  String? get searchValidationMessage =>
      this.fieldsValidationMessages[SearchValueKey];
}

extension Methods on FormViewModel {
  setSearchValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SearchValueKey] = validationMessage;
}

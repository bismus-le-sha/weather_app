import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/location/presentation/cubit/text_field_cubit.dart';

void main() {
  late TextEditingController controller;
  late FocusNode focusNode;
  late TextFieldCubit cubit;

  setUp(() {
    controller = TextEditingController();
    focusNode = FocusNode();
    cubit = TextFieldCubit(focusNode, controller, clearOnUnfocus: true);
  });

  tearDown(() async {
    await cubit.close();
  });

  test('initial state is correct', () {
    // Act
    final initialState = cubit.state;
    // Assert
    expect(initialState, TextFieldState.initial());
  });

  test('emits hasText when text is entered', () {
    // Arrange
    controller.text = 'Hello';
    controller.notifyListeners();

    // Act
    final hasText = cubit.state.hasText;

    // Assert
    expect(hasText, isTrue);
  });

  test('clears text when clear() is called', () {
    // Arrange
    controller.text = 'Hello';

    // Act
    cubit.clear();

    // Assert
    expect(controller.text, '');
    expect(cubit.state.hasText, isFalse);
  });

//TODO: Fix tests for FocusNode
  test('emits hasFocus when focus changes', () {
    // Act
    focusNode.requestFocus();
    final hasFocusAfterRequest = cubit.state.hasFocus;

    focusNode.unfocus();
    final hasFocusAfterUnfocus = cubit.state.hasFocus;

    // Assert
    expect(hasFocusAfterRequest, isTrue);
    expect(hasFocusAfterUnfocus, isFalse);
  });

  test('clears text when focus is lost and clearOnUnfocus is true', () {
    // Arrange
    controller.text = 'Hello';

    // Act
    focusNode.unfocus();

    // Assert
    expect(controller.text, '');
    expect(cubit.state.hasText, isFalse);
  });
}

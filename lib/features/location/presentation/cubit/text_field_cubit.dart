import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'text_field_state.dart';

class TextFieldCubit extends Cubit<TextFieldState> {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool clearOnUnfocus;

  TextFieldCubit(this.focusNode, this.controller, {this.clearOnUnfocus = false})
      : super(TextFieldState.initial()) {
    focusNode.addListener(_onFocusChange);
    controller.addListener(_handleTextChange);
  }

  void _onFocusChange() {
    final hasFocus = focusNode.hasFocus;

    if (!hasFocus && clearOnUnfocus && state.hasText) {
      controller.clear();
      emit(state.copyWith(hasFocus: false, hasText: false));
    } else if (state.hasFocus != hasFocus) {
      emit(state.copyWith(hasFocus: hasFocus));
    }
  }

  void _handleTextChange() {
    final hasText = controller.text.isNotEmpty;
    if (state.hasText != hasText) {
      emit(state.copyWith(hasText: hasText));
    }
  }

  void clear() {
    if (controller.text.isNotEmpty) {
      controller.clear();
      emit(state.copyWith(hasText: false));
    }
  }

  @override
  Future<void> close() {
    focusNode.removeListener(_onFocusChange);
    controller.removeListener(_handleTextChange);
    focusNode.dispose();
    controller.dispose();
    return super.close();
  }
}

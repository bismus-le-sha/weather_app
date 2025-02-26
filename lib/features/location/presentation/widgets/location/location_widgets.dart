import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/text_field_cubit.dart';
import 'location_display.dart';

class LocationTitle extends StatelessWidget {
  const LocationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TextFieldCubit, TextFieldState, bool>(
      selector: (state) => state.hasFocus,
      builder: (context, hasFocus) {
        return AnimatedPositioned(
          top: hasFocus ? -50 : 0.2 * kToolbarHeight + 20,
          left: 20,
          duration: const Duration(milliseconds: 300),
          child: Opacity(
            opacity: hasFocus ? 0 : 1,
            child: const Text(
              'Location Page',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}

class OverlayWithTextFieldFocus extends StatelessWidget {
  const OverlayWithTextFieldFocus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TextFieldCubit, TextFieldState, bool>(
      selector: (state) => state.hasFocus,
      builder: (context, hasFocus) {
        return hasFocus
            ? Positioned.fill(
                child: IgnorePointer(
                  ignoring: true,
                  child: BlocBuilder<TextFieldCubit, TextFieldState>(
                    builder: (context, state) {
                      return Container(
                        color: state.hasText
                            ? Colors.white
                            : Colors.black.withAlpha(50),
                      );
                    },
                  ),
                ),
              )
            : Container();
      },
    );
  }
}

class LocationInputField extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const LocationInputField(this.screenWidth, this.screenHeight, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TextFieldCubit, TextFieldState, bool>(
      selector: (state) => state.hasFocus,
      builder: (context, hasFocus) {
        return AnimatedPositioned(
          top: hasFocus ? 0 : screenHeight * .05 + 20,
          left: 20,
          width: screenWidth * .9,
          duration: const Duration(milliseconds: 300),
          child: const LocationDisplay(),
        );
      },
    );
  }
}

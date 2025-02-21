part of 'text_field_cubit.dart';

class TextFieldState extends Equatable {
  const TextFieldState({required this.hasFocus, required this.hasText});

  final bool hasFocus;
  final bool hasText;

  factory TextFieldState.initial() =>
      const TextFieldState(hasFocus: false, hasText: false);

  TextFieldState copyWith({bool? hasFocus, bool? hasText}) {
    return TextFieldState(
      hasFocus: hasFocus ?? this.hasFocus,
      hasText: hasText ?? this.hasText,
    );
  }

  @override
  List<Object> get props => [hasFocus, hasText];
}

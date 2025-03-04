// import 'dart:io';

// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:weather_app/features/weather/domain/entities/weather.dart';
// import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
// import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
// import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';
// import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';

// class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
//     implements WeatherBloc {}

// void main() {
//   late MockWeatherBloc mockWeatherBloc;

//   setUp(() {
//     mockWeatherBloc = MockWeatherBloc();
//     HttpOverrides.global = null;
//   });

//   Widget makeTestableWidget(Widget body) {
//     return BlocProvider<WeatherBloc>(
//       create: (context) => mockWeatherBloc,
//       child: MaterialApp(
//         home: body,
//       ),
//     );
//   }

//   final testWeather = WeatherEntity(
//     cityName: 'London',
//     lastUpdated: DateTime.parse('2021-02-21 08:42:00'),
//     temperature: 11.0,
//     feelsLike: 9.5,
//     isDay: 1,
//     conditionCode: 1003,
//     conditionText: 'Partly cloudy',
//     conditionIconUrl: 'https://cdn.weatherapi.com/weather/64x64/day/116.png',
//     windSpeed: 6.1,
//   );

//   testWidgets(
//     'text field should trigger state to change from empty to loading',
//     (widgetTester) async {
//       //arrange
//       when(() => mockWeatherBloc.state).thenReturn(() => WeatherInitial());

//       //act
//       await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage(
//         cityName: 'London',
//       )));
//       var textField = find.byType(TextField);
//       expect(textField, findsOneWidget);
//       await widgetTester.enterText(textField, 'New York');
//       await widgetTester.pump();
//       expect(find.text('New York'), findsOneWidget);
//     },
//   );

//   testWidgets(
//     'should show progress indicator when state is loading',
//     (widgetTester) async {
//       //arrange
//       when(() => mockWeatherBloc.state).thenReturn(() => WeatherLoading());

//       //act
//       await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage(
//         cityName: 'London',
//       )));

//       //assert
//       expect(find.byType(CircularProgressIndicator), findsOneWidget);
//     },
//   );

//   testWidgets(
//     'should show widget contain weather data when state is weather loaded',
//     (widgetTester) async {
//       //arrange
//       when(() => mockWeatherBloc.state)
//           .thenReturn(() => WeatherLoaded(testWeather));

//       //act
//       await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage(
//         cityName: 'London',
//       )));

//       //assert
//       expect(find.byKey(const Key('weather_data')), findsOneWidget);
//     },
//   );
// }

import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_clean_architecture_tdd/domain/entities/weather.dart';
import 'package:weather_clean_architecture_tdd/presentation/bloc/bloc/weather_bloc.dart';
import 'package:weather_clean_architecture_tdd/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Text field should trigger state change from initial to loading.',
      (widgetTester) async {
    whenListen(
      mockWeatherBloc,
      Stream.fromIterable(
        [
          WeatherInitial(),
        ],
      ),
      initialState: WeatherInitial(),
    );
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await widgetTester.enterText(textField, 'New York');
    await widgetTester.pumpAndSettle();
    expect(find.text('New York'), findsOneWidget);
  });

  testWidgets('Should show loading indicator when state is loading.',
      (widgetTester) async {
    whenListen(
      mockWeatherBloc,
      Stream.fromIterable(
        [
          WeatherLoading(),
        ],
      ),
      initialState: WeatherLoading(),
    );
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should show weather text when state is loaded.',
      (widgetTester) async {
    const testWeatherEntity = WeatherEntity(
      cityName: 'New York',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      humidity: 70,
      pressure: 1009,
    );

    whenListen(
      mockWeatherBloc,
      Stream.fromIterable(
        [
          const WeatherLoaded(result: testWeatherEntity),
        ],
      ),
      initialState: const WeatherLoaded(result: testWeatherEntity),
    );

    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await widgetTester.enterText(textField, 'New York');
    await widgetTester.pump();

    expect(find.textContaining('Current Weather:'), findsOneWidget);
  });
}

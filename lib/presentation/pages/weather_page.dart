import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_clean_architecture_tdd/presentation/bloc/bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Weather',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                label: const Text('Enter city name'),
                fillColor: Colors.grey[200]!,
                filled: true,
              ),
              onChanged: (value) => context
                  .read<WeatherBloc>()
                  .add(OnCityChanged(cityName: value.trim())),
            ),
            const SizedBox(
              height: 16.0,
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is WeatherLoadFailure) {
                  return const Text('Error fetching weather!');
                }
                if (state is WeatherLoaded) {
                  return Text('Current Weather: ${state.result.toString()}');
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

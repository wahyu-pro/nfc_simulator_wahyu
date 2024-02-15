import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:simulator_read_nfc/bloc/nfc_bloc.dart';
import 'package:simulator_read_nfc/di/injector.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NFCBloc>(),
      child: const MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NFCBloc, NfcTag?>(
      builder: (_, state) => Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              (state != null)
                  ? 'data card : ${state.data}'
                  : 'Click button to start session',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<NFCBloc>().startSession(),
          tooltip: 'Increment',
          child: const Icon(Icons.refresh_sharp),
        ),
      ),
    );
  }
}

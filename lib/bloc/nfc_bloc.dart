import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nfc_manager/nfc_manager.dart';

@injectable
class NFCBloc extends Cubit<NfcTag?> {
  NFCBloc() : super(null);

  void startSession() async {
    /// instance nfc manager
    final nfcManager = NfcManager.instance;

    /// check availability nfc
    bool isAvailable = await nfcManager.isAvailable();

    if (isAvailable) {
      /// Start Session

      await nfcManager.startSession(
        alertMessage:
            "Tap and Hold your NFC card (between 10s) close to the back or front of your phone, usually near the camera. Restart the app if it doesn't work.",
        onDiscovered: (NfcTag tag) async {
          emit(tag);
          nfcManager.stopSession(alertMessage: "Card Found");
        },
        onError: (error) async {
          nfcManager.stopSession(
            errorMessage: error.message,
          );
          debugPrint("error detail : ${error.details}");
        },
      );
    }
  }
}

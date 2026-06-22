import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/data_bank_service.dart';
import 'data_bank_event.dart';
import 'data_bank_state.dart';

class DataBankBloc extends Bloc<DataBankEvent, DataBankState> {
  final DataBankService _dataBankService = DataBankService();

  DataBankBloc() : super(DataBankInitial()) {
    on<SubmitDataRequest>(_onSubmitDataRequest);
  }

  Future<void> _onSubmitDataRequest(
    SubmitDataRequest event,
    Emitter<DataBankState> emit,
  ) async {
    if (event.userEmail.isEmpty || event.location.isEmpty) {
      emit(DataBankFailure("Please fill in all fields!"));
      return;
    }

    emit(DataBankLoading());

    try {
      final isLaunched = await _dataBankService.sendDataRequest(
        userEmail: event.userEmail,
        location: event.location,
        formattedDate: event.formattedDate,
      );

      if (isLaunched) {
        emit(DataBankSuccess());
      } else {
        emit(DataBankFailure("Failed to open email application."));
      }
    } catch (e) {
      emit(DataBankFailure("No email client application found on this device."));
    }
  }
}
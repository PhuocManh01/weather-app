abstract class DataBankState {}

class DataBankInitial extends DataBankState {}

class DataBankLoading extends DataBankState {}

class DataBankSuccess extends DataBankState {}

class DataBankFailure extends DataBankState {
  final String error;
  DataBankFailure(this.error);
}
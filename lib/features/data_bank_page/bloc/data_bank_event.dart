abstract class DataBankEvent {}

class SubmitDataRequest extends DataBankEvent {
  final String userEmail;
  final String location;
  final String formattedDate;

  SubmitDataRequest({
    required this.userEmail,
    required this.location,
    required this.formattedDate,
  });
}
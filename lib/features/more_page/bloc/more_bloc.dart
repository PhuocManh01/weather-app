// lib/features/more/bloc/more_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'more_event.dart';
import 'more_state.dart';

class MoreBloc extends Bloc<MoreEvent, MoreState> {
  // Giả sử bạn có MoreService để xử lý check quyền hoặc auth
  // final MoreService moreService; 

  MoreBloc(AuthCubit read) : super(MoreInitialState()) {
    
    // Xử lý sự kiện bấm vào Profile
    on<NavigateToProfileEvent>((event, emit) {
      emit(MoreLoadingState());
      // Bạn có thể thêm logic check đăng nhập tại đây thông qua AuthCubit/MoreService
      emit(NavigateToProfileState());
    });

    // Xử lý sự kiện bấm vào FAQ
    on<NavigateToFaqEvent>((event, emit) {
      emit(NavigateToFaqState());
    });

    // Xử lý sự kiện bấm vào Contact Us
    on<NavigateToContactUsEvent>((event, emit) {
      emit(NavigateToContactUsState());
    });
  }
}
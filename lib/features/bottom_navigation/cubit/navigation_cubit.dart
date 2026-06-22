// features/bottom_navigation/bloc/navigation_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/auth/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/cubit/auth_state.dart';

// Định nghĩa các State của Navigation
abstract class NavigationState {
  final int currentIndex;
  NavigationState(this.currentIndex);
}

// State bình thường khi chuyển tab thành công
class NavigationInitial extends NavigationState {
  NavigationInitial(super.currentIndex);
}

// State đặc biệt phát ra khi dính lỗi "403" (Chưa đăng nhập mà đòi vào trang cấm)
class NavigationUnauthorizedError extends NavigationState {
  final String message;
  NavigationUnauthorizedError({required int lastIndex, required this.message}) : super(lastIndex);
}

class NavigationCubit extends Cubit<NavigationState> {
  final AuthCubit _authCubit;

  NavigationCubit({required AuthCubit authCubit}) 
      : _authCubit = authCubit, 
        super(NavigationInitial(0));

  void changeTab(int index) { 
    if (state.currentIndex == index) return;

    if (index == 1 || index == 2) {
      if (_authCubit.state is! AuthSuccess) {
        emit(NavigationUnauthorizedError(
          lastIndex: state.currentIndex,
          message: "Your access request has been denied!",
        ));
        return;
      }
    }
    emit(NavigationInitial(index));
  }
}
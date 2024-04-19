part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<HomeModel> listHome;

  const HomeSuccess({required this.listHome});
    @override
  List<Object> get props => [listHome];
}

final class HomeFailed extends HomeState {
  final String message;

  const HomeFailed({required this.message});
    @override
  List<Object> get props => [message];
}



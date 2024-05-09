part of 'loading_cubit.dart';

class LoadingInitial extends Equatable {
  final bool isLoading;

  const LoadingInitial({required this.isLoading});

  factory LoadingInitial.initial() {
    return const LoadingInitial(isLoading: false);
  }

  @override
  List<Object> get props => [isLoading];

  LoadingInitial copyWith({
    bool? isLoading,
  }) {
    return LoadingInitial(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

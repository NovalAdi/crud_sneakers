part of 'sneaker_cubit.dart';

class SneakerState extends Equatable {
  final bool isLoading;
  final List<Sneaker> sneakers;
  final String message;
  final bool isSuccess;

  const SneakerState({
    this.isLoading = false,
    this.sneakers = const [],
    this.message = '',
    this.isSuccess = false,
  });

  SneakerState copyWith({
    bool? isLoading,
    List<Sneaker>? sneakers,
    String? message,
    bool? isSuccess,
  }) =>
      SneakerState(
        sneakers: sneakers ?? this.sneakers,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isSuccess: isSuccess ?? this.isSuccess,
      );

  @override
  List<Object> get props => [
        isLoading,
        sneakers,
        message,
        isSuccess,
      ];
}

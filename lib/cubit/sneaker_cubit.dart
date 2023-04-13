import 'package:bloc/bloc.dart';
import 'package:crud_sneakers/models/sneaker.dart';
import 'package:crud_sneakers/services/sneaker_service.dart';
import 'package:equatable/equatable.dart';

part 'sneaker_state.dart';

class SneakerCubit extends Cubit<SneakerState> {
  SneakerCubit() : super(const SneakerState());

  void init() {
    getSneakers();
  }

  void getSneakers() async {
    emit(state.copyWith(isLoading: true));
    List<Sneaker>? sneakers = await SneakerService.getSneakers();
    emit(state.copyWith(sneakers: sneakers));
    emit(state.copyWith(isLoading: false));
  }

  void createSneakers(
    String name,
    String brand,
    String type,
  ) async {
    emit(state.copyWith(isLoading: true));
    await SneakerService.createSneakers(
      name: name,
      brand: brand,
      type: type,
    );
    getSneakers();
    emit(state.copyWith(isLoading: false));
  }

  void updateSneakers(
    int id,
    String name,
    String brand,
    String type,
  ) async {
    emit(state.copyWith(isLoading: true));
    await SneakerService.updateSneaker(
      id: id,
      name: name,
      brand: brand,
      type: type,
    );
    getSneakers();
    emit(state.copyWith(isLoading: false));
  }

  void deleteSneakers(int id) async {
    emit(state.copyWith(isLoading: true));
    await SneakerService.deleteSneaker(id);
    getSneakers();
    emit(state.copyWith(isLoading: false));
  }
}

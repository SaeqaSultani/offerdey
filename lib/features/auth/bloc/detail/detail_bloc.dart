import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/params.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(const DetailState(RegisterParam(), 0)) {
    on<BackPreviousPage>((event, emit) {
      emit(DetailState(state.params, state.detailIndex - 1));
    });

    on<ToNextPage>((event, emit) {
      emit(DetailState(state.params, state.detailIndex + 1));
    });

    on<SetBasicDetail>((event, emit) {
      emit(
        DetailState(
          RegisterParam(
            email: event.params.email,
            password: event.params.password,
            name: event.params.name,
            contactNumber: event.params.contactNumber,
            vehicleNumber: state.params.vehicleNumber,
            vehicleColor: state.params.vehicleColor,
            vehicleModel: state.params.vehicleModel,
            referBy: state.params.referBy,
          ),
          1,
        ),
      );
    });

    on<SetVehicleDetail>((event, emit) {
      emit(
        DetailState(
          RegisterParam(
            email: state.params.email,
            password: state.params.password,
            name: state.params.name,
            contactNumber: state.params.contactNumber,
            vehicleNumber: event.params.vehicleNumber,
            vehicleColor: event.params.vehicleColor,
            vehicleModel: event.params.vehicleModel,
            referBy: event.params.referBy,
          ),
          2,
        ),
      );
    });
  }
}

part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  final RegisterParam params;
  const DetailEvent(this.params);

  @override
  List<Object> get props => [params];
}

class SetBasicDetail extends DetailEvent {
  SetBasicDetail({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) : super(
          RegisterParam(
            email: email,
            password: password,
            name: name,
            contactNumber: phoneNumber,
          ),
        );
}

class SetVehicleDetail extends DetailEvent {
  SetVehicleDetail({
    required String vehicleNumber,
    required String vehicleColor,
    required String vehicleModel,
    required String referBy,
  }) : super(
          RegisterParam(
            vehicleNumber: vehicleNumber,
            vehicleColor: vehicleColor,
            vehicleModel: vehicleModel,
            referBy: referBy,
          ),
        );
}

class BackPreviousPage extends DetailEvent {
  const BackPreviousPage() : super(const RegisterParam());
}

class ToNextPage extends DetailEvent {
  const ToNextPage() : super(const RegisterParam());
}

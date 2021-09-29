part of 'detail_bloc.dart';

class DetailState extends Equatable {
  final RegisterParam params;
  final int detailIndex;
  const DetailState(this.params, this.detailIndex);

  @override
  List<Object> get props => [params, detailIndex];
}

class InfoDetailCompleted extends DetailState {
  const InfoDetailCompleted(RegisterParam params, int detailIndex)
      : super(params, detailIndex);
}

class AllDetailCompleted extends DetailState {
  const AllDetailCompleted(RegisterParam params, int detailIndex)
      : super(params, detailIndex);
}

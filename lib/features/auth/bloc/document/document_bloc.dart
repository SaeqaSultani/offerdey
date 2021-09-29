import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/network/params.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc()
      : super(
          const DocumentState(
            DocumentParam(
                riderId: -1,
                depositAmountSlipPath: '',
                licenceFrontPath: '',
                licenceBackPath: '',
                cnicFrontPath: '',
                cnicBackPath: ''),
          ),
        ) {
    on<SetLicenceFront>((event, emit) {
      emit(DocumentLoading(state.params));
      emit(
        DocumentState(
          DocumentParam(
            riderId: state.params.riderId,
            depositAmountSlipPath: state.params.depositAmountSlipPath,
            licenceFrontPath: event.licenceFrontPath,
            licenceBackPath: state.params.licenceBackPath,
            cnicFrontPath: state.params.cnicFrontPath,
            cnicBackPath: state.params.cnicBackPath,
          ),
        ),
      );
    });
    on<SetLicenceBack>((event, emit) {
      emit(DocumentLoading(state.params));
      emit(
        DocumentState(
          DocumentParam(
            riderId: state.params.riderId,
            depositAmountSlipPath: state.params.depositAmountSlipPath,
            licenceFrontPath: state.params.licenceFrontPath,
            licenceBackPath: event.licenceBackPath,
            cnicFrontPath: state.params.cnicFrontPath,
            cnicBackPath: state.params.cnicBackPath,
          ),
        ),
      );
    });
    on<SetCnicFront>((event, emit) {
      emit(DocumentLoading(state.params));
      emit(
        DocumentState(
          DocumentParam(
            riderId: state.params.riderId,
            depositAmountSlipPath: state.params.depositAmountSlipPath,
            licenceFrontPath: state.params.licenceFrontPath,
            licenceBackPath: state.params.licenceBackPath,
            cnicFrontPath: event.cnicFrontPath,
            cnicBackPath: state.params.cnicBackPath,
          ),
        ),
      );
    });
    on<SetCnicBack>((event, emit) {
      emit(DocumentLoading(state.params));
      emit(
        DocumentState(
          DocumentParam(
            riderId: state.params.riderId,
            depositAmountSlipPath: state.params.depositAmountSlipPath,
            licenceFrontPath: state.params.licenceFrontPath,
            licenceBackPath: state.params.licenceBackPath,
            cnicFrontPath: state.params.cnicFrontPath,
            cnicBackPath: event.cnicBackPath,
          ),
        ),
      );
    });
    on<SetDepositSlip>((event, emit) {
      emit(DocumentLoading(state.params));
      emit(
        DocumentState(
          DocumentParam(
            riderId: event.riderId,
            depositAmountSlipPath: event.depositAmountSlipPath,
            licenceFrontPath: state.params.licenceFrontPath,
            licenceBackPath: state.params.licenceBackPath,
            cnicFrontPath: state.params.cnicFrontPath,
            cnicBackPath: state.params.cnicBackPath,
          ),
        ),
      );
    });
  }
}

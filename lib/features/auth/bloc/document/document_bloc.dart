import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentBloc() : super(const DocumentState('', '', '', '')) {
    on<SetLicenceFront>((event, emit) {
      emit(DocumentLoading(state.licenceFrontPath, state.licenceBackPath,
          state.cnicFrontPath, state.cnicBackPath));
      emit(DocumentState(event.licenceFrontPath, state.licenceBackPath,
          state.cnicFrontPath, state.cnicBackPath));
    });
    on<SetLicenceBack>((event, emit) {
      emit(DocumentLoading(state.licenceFrontPath, state.licenceBackPath,
          state.cnicFrontPath, state.cnicBackPath));
      emit(DocumentState(state.licenceFrontPath, event.licenceBackPath,
          state.cnicFrontPath, state.cnicBackPath));
    });
    on<SetCnicFront>((event, emit) {
      emit(DocumentLoading(state.licenceFrontPath, state.licenceBackPath,
          state.cnicFrontPath, state.cnicBackPath));
      emit(DocumentState(state.licenceFrontPath, state.licenceBackPath,
          event.cnicFrontPath, state.cnicBackPath));
    });
    on<SetCnicBack>((event, emit) {
      emit(DocumentLoading(state.licenceFrontPath, state.licenceBackPath,
          state.cnicFrontPath, state.cnicBackPath));
      emit(DocumentState(state.licenceFrontPath, state.licenceBackPath,
          state.cnicFrontPath, event.cnicBackPath));
    });
  }
}

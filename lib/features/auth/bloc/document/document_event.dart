part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class SetLicenceFront extends DocumentEvent {
  final String licenceFrontPath;

  const SetLicenceFront(this.licenceFrontPath);
}

class SetLicenceBack extends DocumentEvent {
  final String licenceBackPath;

  const SetLicenceBack(this.licenceBackPath);
}

class SetCnicFront extends DocumentEvent {
  final String cnicFrontPath;

  const SetCnicFront(this.cnicFrontPath);
}

class SetCnicBack extends DocumentEvent {
  final String cnicBackPath;

  const SetCnicBack(this.cnicBackPath);
}

part of 'document_bloc.dart';

class DocumentState extends Equatable {
  final String licenceFrontPath;
  final String licenceBackPath;
  final String cnicFrontPath;
  final String cnicBackPath;
  const DocumentState(this.licenceFrontPath, this.licenceBackPath,
      this.cnicFrontPath, this.cnicBackPath);

  @override
  List<Object> get props => [licenceFrontPath, cnicBackPath, cnicFrontPath];
}

class DocumentLoading extends DocumentState {
  const DocumentLoading(String licenceFrontPath, String licenceBackPath,
      String cnicFrontPath, String cnicBackPath)
      : super(licenceFrontPath, licenceBackPath, cnicFrontPath, cnicBackPath);
}

part of 'document_bloc.dart';

class DocumentState extends Equatable {
  final DocumentParam params;
  const DocumentState(this.params);

  @override
  List<Object> get props => [params];
}

class DocumentLoading extends DocumentState {
  const DocumentLoading(DocumentParam params) : super(params);
}

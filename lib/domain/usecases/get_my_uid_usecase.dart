import 'package:injectable/injectable.dart';

@injectable
class GetMyUidUseCase {
  final String uid;
  GetMyUidUseCase(this.uid);

  String call() {
    return uid;
  }
}

import '../../../core/core.dart';
import '../../data.dart';

part 'user_repository_impl.dart';

abstract class UserRepository {
  //
  Future<List<Contact>> getContact();
}

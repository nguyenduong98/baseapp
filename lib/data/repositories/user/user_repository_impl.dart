part of 'user_repository.dart';

class UserRepositoryImpl extends BaseRepository implements UserRepository {
  //
  UserRepositoryImpl({required this.api});

  final Api api;

  @override
  Future<List<Contact>> getContact() async {
    List<Contact> contacts = await ContactsService.getContacts();
    return contacts;
  }
}

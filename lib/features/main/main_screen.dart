import '../../core/core.dart';
import 'main_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final cubit = GetIt.instance.get<MainCubit>();

  @override
  void initState() {
    super.initState();
    cubit.getContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DEMO')),
      body: BlocBuilder<MainCubit, MainState>(
        bloc: cubit,
        builder: (_, state) {
          if (state.isLoading) return const SizedBox();
          //
          final contacts = state.contacts ?? [];
          return SizedBox(
            child: ListView.separated(
              itemCount: contacts.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (_, index) => buildContactItem(contacts[index]),
            ),
          );
        },
      ),
    );
  }

  Widget buildContactItem(Contact contact) {
    return Container(child: Text(contact.displayName ?? ''));
  }
}

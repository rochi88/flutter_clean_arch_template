// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import '../../data/test_data.dart';

// import '../providers/notification_controller_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    // final $notification = ref.read(notificationControllerProvider).getData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Notifications',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 30.0,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              context.go('/home');
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(10.0),
          itemBuilder: (BuildContext context, int index) {
            Map notif = notifications[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(notif['dp']),
                  radius: 25,
                ),
                contentPadding: const EdgeInsets.all(0),
                title: Text(notif['note']),
                trailing: Text(
                  notif['time'],
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
                ),
              ),
            );
          },
          separatorBuilder:
              (BuildContext context, int index) => Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 0.5,
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Divider(),
                ),
              ),
          itemCount: notifications.length,
        ),
      ),
    );
  }
}

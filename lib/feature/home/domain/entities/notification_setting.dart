import 'package:equatable/equatable.dart';

class NotificationSetting  extends Equatable{
  final String id;
  final String title;
  final bool isEnabled;

  const NotificationSetting({
    required this.id,
    required this.title,
    required this.isEnabled,
  });

  NotificationSetting copyWith({bool? isEnabled}) {
    return NotificationSetting(
      id: id,
      title: title,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  List<Object?> get props => [id,title,isEnabled];
}


// ============================================================
// features/rsvp/model/rsvp_model.dart
//
// Simple data model for the RSVP form.
// In a real app you'd send this to a backend (Firebase/API).
// ============================================================

class RsvpModel {
  final String name;
  final String phone;
  final bool willAttend;

  const RsvpModel({
    required this.name,
    required this.phone,
    required this.willAttend,
  });

  // Convert to Map (useful for sending to Firebase)
  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'willAttend': willAttend,
    'submittedAt': DateTime.now().toIso8601String(),
  };

  @override
  String toString() =>
      'RsvpModel(name: $name, phone: $phone, attend: $willAttend)';
}
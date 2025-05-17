// Dart imports:
import 'dart:math';

Random random = Random();
List names = [
  'Ling Waldner',
  'Gricelda Barrera',
  'Lenard Milton',
  'Bryant Marley',
  'Rosalva Sadberry',
  'Guadalupe Ratledge',
  'Brandy Gazda',
  'Kurt Toms',
  'Rosario Gathright',
  'Kim Delph',
  'Stacy Christensen',
];

List notifs = [
  '${names[random.nextInt(10)]} and ${random.nextInt(100)} others liked your post',
  '${names[random.nextInt(10)]} mentioned you in a comment',
  '${names[random.nextInt(10)]} shared your post',
  '${names[random.nextInt(10)]} commented on your post',
  '${names[random.nextInt(10)]} replied to your comment',
  '${names[random.nextInt(10)]} reacted to your comment',
  '${names[random.nextInt(10)]} asked you to join a Group️',
  '${names[random.nextInt(10)]} asked you to like a page',
  'You have memories with ${names[random.nextInt(10)]}',
  '${names[random.nextInt(10)]} Tagged you and ${random.nextInt(100)} others in a post',
  '${names[random.nextInt(10)]} Sent you a friend request',
];

List notifications = List.generate(
  13,
  (index) => {
    'name': names[random.nextInt(10)],
    // 'dp': 'https://i.pravatar.cc/10${random.nextInt(10)}',
    'dp': 'https://i.pravatar.cc/100',
    'time': '${random.nextInt(50)} min ago',
    'note': notifs[random.nextInt(10)],
  },
);

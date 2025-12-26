📦 Using Hive in Flutter

Hive is a lightweight, fast, NoSQL database for Flutter applications. It is ideal for storing small to medium amounts of data locally on the device — such as notes, preferences, settings, or cached data.

🚀 Why Choose Hive?

⚡ Very fast (written in pure Dart)

📱 Works offline

🧱 No native dependencies (easy to install)

🗂️ Supports typed boxes for structured data

🔐 Optional encryption for secure storage

📥 Installation

Add Hive packages:

flutter pub add hive hive_flutter
flutter pub add --dev hive_generator build_runner


Initialize Hive in your project (usually in main.dart):

await Hive.initFlutter();
await Hive.openBox('myBox');

🧩 Creating a Model

To store custom objects, create a model and annotate it:

import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  Note({
    required this.title,
    required this.content,
  });
}


Generate the adapter:

flutter pub run build_runner build


Then register the adapter:

Hive.registerAdapter(NoteAdapter());

🗄️ Storing Data
var box = Hive.box<Note>('notes');
box.add(Note(title: 'Hello', content: 'This is a note'));

📤 Retrieving Data
var box = Hive.box<Note>('notes');
var note = box.getAt(0);
print(note?.title);

🗑️ Deleting Data
box.deleteAt(0);

👀 Listening for Changes

Hive supports live updates:

ValueListenableBuilder(
  valueListenable: Hive.box<Note>('notes').listenable(),
  builder: (context, box, _) {
    return Text("Total notes: ${box.length}");
  },
);
...

import 'package:diastore_flutter/model/Entry.dart';
import 'package:diastore_flutter/views/EntryCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Entries extends StatefulWidget {
  @override
  EntriesState createState() => new EntriesState();
}

class EntriesState extends State<Entries> {
  final List<Entry> entries = [
    Entry(Uuid().v1(), 124, 2, 3.0, "7:00", "10/10/10", 40,
        MomentSpecifier.BEFORE_MEAL, MealTypeSpecifier.BREAKFAST),
    Entry(Uuid().v1(), 80, 2, 3.0, "7:00", "10/10/10", 40,
        MomentSpecifier.AFTER_MEAL, MealTypeSpecifier.BREAKFAST),
    Entry(Uuid().v1(), 105, 2, 3.0, "7:00", "10/10/10", 40,
        MomentSpecifier.BEFORE_MEAL, MealTypeSpecifier.LUNCH),
    Entry(Uuid().v1(), 106, 2, 3.0, "7:00", "10/10/10", 40,
        MomentSpecifier.AFTER_MEAL, MealTypeSpecifier.LUNCH),
    Entry(Uuid().v1(), 107, 2, 3.0, "7:00", "10/10/10", 40,
        MomentSpecifier.BEFORE_MEAL, MealTypeSpecifier.DINNER),
    Entry(Uuid().v1(), 108, 2, 3.0, "7:00", "10/10/10", 40,
        MomentSpecifier.AFTER_MEAL, MealTypeSpecifier.DINNER),
  ];

  @override
  Widget build(BuildContext context) {
    return  _buildSuggestions();
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: entries.length,
        itemBuilder: (BuildContext _context, int i) {
          return EntryCard(entries[i], () => setState(() { entries.removeAt(i);}));
        });
  }
}
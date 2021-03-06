import 'package:diastore_flutter/model/Entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../feature/details/EntryDetailsScreen.dart';

class EntryCard extends StatelessWidget {
  final Entry entry;
  final Function onCloseTap;
  final Function detailsCallback;

  EntryCard(this.entry, this.onCloseTap, this.detailsCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: InkWell(
          onTap: () =>
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EntryDetailsState(entry, detailsCallback),
              ),
            ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(entry.bloodSugarLevel.toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.centerLeft,
                    child: Column(children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                    "Carbs: ${entry.carbohydratesIntake}")),
                            Expanded(
                                child: Text("Insulin: ${entry.insulinIntake}")),
                            Expanded(
                                child: Text(
                                    "Sport: ${entry.physicalActivityDuration}")),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[Text(entry.entryHour)],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "${entry.entryTime} ${entry.getMomentString()}")
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  width: 24,
                  margin: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => this.onCloseTap(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  }
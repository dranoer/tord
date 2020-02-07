import 'package:flutter/material.dart';
import 'package:truth_or_dare/components/selectable_row.dart';
import 'package:truth_or_dare/models/arguments.dart';
import 'package:truth_or_dare/screens/name_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {@required this.args, this.range, this.name, this.imageName});

  final ScreenArguments args;
  final int range;
  final String name;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 60.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, NameScreen.id,
              arguments: ScreenArguments(
                range: range,
                advancedPlayer: args.advancedPlayer,
                soundHandler: args.soundHandler,
              ));
        },
        child: SelectableRow(
            name: name, imageRoot: imageName, color: Colors.grey[700]),
      ),
    );
  }
}

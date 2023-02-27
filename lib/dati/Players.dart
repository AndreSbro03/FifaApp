import 'package:flutter/material.dart';

final String tablePlayers = 'players';

class PlayerFields {
  static final List<String> values = [
    /// Add all fields
    id, image, name, color
  ];

  static final String id = '_id';
  static final String image = 'image';
  static final String name = 'name';
  static final String color = 'color';
}

class Player {
  final int? id;
  final String image;
  final String name;
  final Color color;

  const Player({
    this.id,
    required this.image,
    required this.name,
    required this.color,
  });

  static Player fromJson(Map<String, Object?> json) => Player(
      id: json[PlayerFields.id] as int?,
      image: json[PlayerFields.image] as String,
      name: json[PlayerFields.name] as String,
      color: Color(json[PlayerFields.color] as int),);


  Map<String, Object?> toJson() => {
        PlayerFields.id: id,
        PlayerFields.image: image,
        PlayerFields.name: name,
        //For bolean or special type we have to convert the value+        
        PlayerFields.color: color.value //save this in your database.
      };

  Player copy({
    int? id,
    String? image,
    String? name,
    Color? color,
  }) =>
      Player(
          id: id ?? this.id,
          image: image ?? this.image,
          name: name ?? this.name,
          color: color ?? this.color,);
}




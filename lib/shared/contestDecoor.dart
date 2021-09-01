import 'package:flutter/material.dart';

const contestDecor = InputDecoration(
  border: InputBorder.none,
  enabled: true,
  filled: true,
  fillColor: Colors.grey,
  enabledBorder: const OutlineInputBorder(
    borderRadius: const BorderRadius.only(
      topLeft: const Radius.circular(50),
      bottomLeft: const Radius.circular(50),
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.blue,
      width: 2.0,
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.red,
    ),
  ),
);

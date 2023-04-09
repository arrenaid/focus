import 'package:flutter/material.dart';

// const Color col1 = Color(0xFF351409);//
// const Color col2 = Color(0xFFa15501);
// const Color col3 = Color(0xFFd0902f);
// const Color col4 = Color(0xFFfdd870);
// const Color col5 = Color(0xFFfff69f);
const Color col1 = Color(0xFF222831);//
const Color col2 = Color(0xFF393E46);
const Color col3 = Color(0xFFB71C1C);//B71C1C//FFD369
const Color col4 = Color(0xFFa15501);
const Color col5 = Color(0xFFd0902f);

const LinearGradient gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight, //Alignment(0.8, 1),
  colors: <Color>[
    col3,
    col4,
  ],
  tileMode: TileMode.mirror,
);

const TextStyle tsDef = TextStyle(
  fontSize: 50,
  color: col4,
  fontFamily: 'Maximus',
  shadows: [shadowDef],
);
const TextStyle tsUp = TextStyle(
  fontSize: 40,
  backgroundColor: col2,
  color: col3,
  fontFamily: 'Maximus',
  shadows: [shadowDef],
);
const TextStyle tsAlt = TextStyle(
  fontSize: 250,
  color: col2,
  fontFamily: 'Maximus',
  shadows: [shadowDef],
);
const TextStyle tsButton = TextStyle(
  fontSize: 27,
  color: col4,
  fontFamily: 'MaxS',
  shadows: [shadowDef],
);
const TextStyle tsStat= TextStyle(
  fontSize: 30,
  color: col2,
  fontFamily: 'Maximus',
  shadows: [shadowDef],
);
const TextStyle tsStatAlt = TextStyle(
  fontSize: 15,
  color: col5,
  fontFamily: 'MaxS',
  shadows: [shadowDef],
);
const Shadow shadowDef = Shadow(
    offset: Offset(4.0, 4.0),
    blurRadius: 8.0,
    color: col3); //Color(0xFFB71C1C))

// const Color defPriClr = Color(0xFF8D6E63);//351409
// const Color defSecClr = Color(0xFFCDF0EA); // EEE3CB // CDF0EA
// //const Color defBtnClr = Color(0xFF3E2723);

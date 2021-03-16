import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rateyoursleep/services/services.dart';
import 'package:rateyoursleep/models/models.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rateyoursleep/widgets/supertimecard.dart';
import 'package:rateyoursleep/widgets/timecard.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

part 'signin_page.dart';
part 'signup_page.dart';
part 'home.dart';
part 'mainmenu.dart';
part 'mainpage.dart';
part 'listdata.dart';
part 'account_page.dart';
part 'homesettings.dart';

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Search products`
  String get searchHint {
    return Intl.message(
      'Search products',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred, please try again.`
  String get errorMessage {
    return Intl.message(
      'An error occurred, please try again.',
      name: 'errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Beauty`
  String get beauty {
    return Intl.message(
      'Beauty',
      name: 'beauty',
      desc: '',
      args: [],
    );
  }

  /// `Fashion`
  String get fashion {
    return Intl.message(
      'Fashion',
      name: 'fashion',
      desc: '',
      args: [],
    );
  }

  /// `Kids`
  String get kids {
    return Intl.message(
      'Kids',
      name: 'kids',
      desc: '',
      args: [],
    );
  }

  /// `Mens`
  String get mens {
    return Intl.message(
      'Mens',
      name: 'mens',
      desc: '',
      args: [],
    );
  }

  /// `Womens`
  String get womens {
    return Intl.message(
      'Womens',
      name: 'womens',
      desc: '',
      args: [],
    );
  }

  /// `50-40% OFF`
  String get discountOffer {
    return Intl.message(
      '50-40% OFF',
      name: 'discountOffer',
      desc: '',
      args: [],
    );
  }

  /// `Now in (product)`
  String get productPromo {
    return Intl.message(
      'Now in (product)',
      name: 'productPromo',
      desc: '',
      args: [],
    );
  }

  /// `All colors`
  String get allColors {
    return Intl.message(
      'All colors',
      name: 'allColors',
      desc: '',
      args: [],
    );
  }

  /// `Shop Now`
  String get shopNow {
    return Intl.message(
      'Shop Now',
      name: 'shopNow',
      desc: '',
      args: [],
    );
  }

  /// `Deal of the Day`
  String get dealOfTheDay {
    return Intl.message(
      'Deal of the Day',
      name: 'dealOfTheDay',
      desc: '',
      args: [],
    );
  }

  /// `22h 55m 20s remaining`
  String get timeRemaining {
    return Intl.message(
      '22h 55m 20s remaining',
      name: 'timeRemaining',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Special Offers`
  String get specialOffers {
    return Intl.message(
      'Special Offers',
      name: 'specialOffers',
      desc: '',
      args: [],
    );
  }

  /// `We make sure you get the`
  String get specialOffersDescriptionLine1 {
    return Intl.message(
      'We make sure you get the',
      name: 'specialOffersDescriptionLine1',
      desc: '',
      args: [],
    );
  }

  /// `offer you need at best prices`
  String get specialOffersDescriptionLine2 {
    return Intl.message(
      'offer you need at best prices',
      name: 'specialOffersDescriptionLine2',
      desc: '',
      args: [],
    );
  }

  /// `Flat and Heels`
  String get flatAndHeels {
    return Intl.message(
      'Flat and Heels',
      name: 'flatAndHeels',
      desc: '',
      args: [],
    );
  }

  /// `Stand a chance to get rewarded`
  String get rewardMessage {
    return Intl.message(
      'Stand a chance to get rewarded',
      name: 'rewardMessage',
      desc: '',
      args: [],
    );
  }

  /// `Visit now`
  String get visitNow {
    return Intl.message(
      'Visit now',
      name: 'visitNow',
      desc: '',
      args: [],
    );
  }

  /// `Nike Sneakers`
  String get nikeSneakers {
    return Intl.message(
      'Nike Sneakers',
      name: 'nikeSneakers',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Perhaps the most iconic sneaker of all-time, this original\n'Chicago' colorway is the cornerstone to any sneaker\ncollection. Made famous in 1985 by Michael Jordan, the\nshoe has stood the test of time, becoming the most\nfamous colorway of the Air Jordan 1. This 2015 release saw\nthe.\nshoe has stood the test of time, becoming the most in 2024.\n`
  String get readMoreText {
    return Intl.message(
      'Perhaps the most iconic sneaker of all-time, this original\n\'Chicago\' colorway is the cornerstone to any sneaker\ncollection. Made famous in 1985 by Michael Jordan, the\nshoe has stood the test of time, becoming the most\nfamous colorway of the Air Jordan 1. This 2015 release saw\nthe.\nshoe has stood the test of time, becoming the most in 2024.\n',
      name: 'readMoreText',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Less`
  String get less {
    return Intl.message(
      'Less',
      name: 'less',
      desc: '',
      args: [],
    );
  }

  /// `Delivery in`
  String get deliveryIn {
    return Intl.message(
      'Delivery in',
      name: 'deliveryIn',
      desc: '',
      args: [],
    );
  }

  /// `1 within Hour`
  String get deliveryTime {
    return Intl.message(
      '1 within Hour',
      name: 'deliveryTime',
      desc: '',
      args: [],
    );
  }

  /// `View Similar`
  String get viewSimilar {
    return Intl.message(
      'View Similar',
      name: 'viewSimilar',
      desc: '',
      args: [],
    );
  }

  /// `Add to Compare`
  String get addToCompare {
    return Intl.message(
      'Add to Compare',
      name: 'addToCompare',
      desc: '',
      args: [],
    );
  }

  /// `Similar To`
  String get similarTo {
    return Intl.message(
      'Similar To',
      name: 'similarTo',
      desc: '',
      args: [],
    );
  }

  /// `282+ Items`
  String get itemsCount {
    return Intl.message(
      '282+ Items',
      name: 'itemsCount',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Signed up successfully`
  String get signedUpSuccessfully {
    return Intl.message(
      'Signed up successfully',
      name: 'signedUpSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Back!`
  String get back {
    return Intl.message(
      'Back!',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Username or Email`
  String get usernameOrEmail {
    return Intl.message(
      'Username or Email',
      name: 'usernameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Signed in successfully`
  String get signedInSuccessfully {
    return Intl.message(
      'Signed in successfully',
      name: 'signedInSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error_title {
    return Intl.message(
      'Error',
      name: 'error_title',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get no_internet_message {
    return Intl.message(
      'No Internet Connection',
      name: 'no_internet_message',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorTitle {
    return Intl.message(
      'Error',
      name: 'errorTitle',
      desc: 'Title of the error message in snackbar',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetMessage {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetMessage',
      desc: 'Message displayed when there is no internet connection',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get cancel {
    return Intl.message(
      'CANCEL',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get save {
    return Intl.message(
      'SAVE',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Changes discarded.`
  String get discardChanges {
    return Intl.message(
      'Changes discarded.',
      name: 'discardChanges',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully!`
  String get profileUpdated {
    return Intl.message(
      'Profile updated successfully!',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

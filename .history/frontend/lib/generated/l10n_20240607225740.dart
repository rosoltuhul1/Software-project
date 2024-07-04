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

  /// `Account`
  String get Account {
    return Intl.message(
      'Account',
      name: 'Account',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get Lang_type {
    return Intl.message(
      'English',
      name: 'Lang_type',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get Chnage_pass {
    return Intl.message(
      'Change Password',
      name: 'Chnage_pass',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get Dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'Dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Send Feedback`
  String get Send_feedback {
    return Intl.message(
      'Send Feedback',
      name: 'Send_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message(
      'Categories',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

/// `Categories`
  String get Places {
    return Intl.message(
      'Places',
      name: 'Places',
      desc: '',
      args: [],
    );
  }
  /// `View All`
  String get view_all {
    return Intl.message(
      'View All',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  String get Events {
    return Intl.message(
      'Events',
      name: 'Events',
      desc: '',
      args: [],
    );
  }

  String get Wedding {
    return Intl.message(
      'Wedding',
      name: 'Wedding',
      desc: '',
      args: [],
    );
  }

  String get Birth {
    return Intl.message(
      'Birth',
      name: 'Birth',
      desc: '',
      args: [],
    );
  }

  String get Graduation {
    return Intl.message(
      'Graduation',
      name: 'Graduation',
      desc: '',
      args: [],
    );
  }
  /// `Search Items`
  String get Search {
    return Intl.message(
      'Search Items',
      name: 'Search',
      desc: '',
      args: [],
    );
  }


  String get Reels {
    return Intl.message(
      'Reels',
      name: 'Reels',
      desc: '',
      args: [],
    );
  }



String get Pictures {
    return Intl.message(
      'Pictures',
      name: 'Pictures',
      desc: '',
      args: [],
    );
  }


  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get Offers {
    return Intl.message(
      'Offers',
      name: 'Offers',
      desc: '',
      args: [],
    );
  }

  /// `Recently added`
  String get New_new {
    return Intl.message(
      "what's new",
      name: 'New_new',
      desc: '',
      args: [],
    );
  }

  /// ` Details`
  String get Details {
    return Intl.message(
      ' Details',
      name: 'Details',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// ` Description`
  String get Description {
    return Intl.message(
      ' Description',
      name: 'Description',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Category {
    return Intl.message(
      'Category',
      name: 'Category',
      desc: '',
      args: [],
    );
  }


  String get Resturants {
    return Intl.message(
      'Resturants',
      name: 'Resturants',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date {
    return Intl.message(
      'Date',
      name: 'Date',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get Phone {
    return Intl.message(
      'Phone',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `No items to display.`
  String get Message_No_post {
    return Intl.message(
      'No Posts yet .',
      name: 'Message_No_post',
      desc: '',
      args: [],
    );
  }

  /// `Click to add item`
  String get part_of_work {
    return Intl.message(
      'Do you want to be part of this work?',
      name: 'part_of_work',
      desc: '',
      args: [],
    );
  }

  /// `Add image here`
  String get add_image {
    return Intl.message(
      'Add image here',
      name: 'add_image',
      desc: '',
      args: [],
    );
  }

  /// `You can remove an image by tapping on it.`
  String get remove_image {
    return Intl.message(
      'You can remove an image by tapping on it.',
      name: 'remove_image',
      desc: '',
      args: [],
    );
  }

  /// `Item name`
  String get post_description {
    return Intl.message(
      'Post Description ',
      name: 'post_description',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Pick from Gallery`
  String get pick_from_gallery {
    return Intl.message(
      'Pick from Gallery',
      name: 'pick_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Take a Photo`
  String get take_photo {
    return Intl.message(
      'Take a Photo',
      name: 'take_photo',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Back {
    return Intl.message(
      'Back',
      name: 'Back',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get Upload {
    return Intl.message(
      'Upload',
      name: 'Upload',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get Select {
    return Intl.message(
      'Select',
      name: 'Select',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get Complete {
    return Intl.message(
      'Complete',
      name: 'Complete',
      desc: '',
      args: [],
    );
  }

  /// `Recent Chats`
  String get Recent_chats {
    return Intl.message(
      'Recent Chats',
      name: 'Recent_chats',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message(
      'See All',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }


  /// `SoftCopy Slides`
  String get softcopy_slides {
    return Intl.message(
      'SoftCopy Slides',
      name: 'softcopy_slides',
      desc: '',
      args: [],
    );
  }

  String get My_Posts {
    return Intl.message(
      'My Posts',
      name: 'My_Posts',
      desc: '',
      args: [],
    );
  }

  /// `Requests`
  String get Requests {
    return Intl.message(
      'Requests',
      name: 'Requests',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get Delete {
    return Intl.message(
      'Delete',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get Edit {
    return Intl.message(
      'Edit',
      name: 'Edit',
      desc: '',
      args: [],
    );
  }

  /// `Hardware`
  String get Hardware {
    return Intl.message(
      'Hardware',
      name: 'Hardware',
      desc: '',
      args: [],
    );
  }

  /// `Software`
  String get Software {
    return Intl.message(
      'Software',
      name: 'Software',
      desc: '',
      args: [],
    );
  }

 
  String get select_post_type {
    return Intl.message(
      'Please Select your post type ',
      name: 'select_post_type',
      desc: '',
      args: [],
    );
  }


  String get level {
    return Intl.message(
      'level',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  
  String get Post_type {
    return Intl.message(
      'Post Type',
      name: 'Post_type',
      desc: '',
      args: [],
    );
  }

  /// `Type your message here...`
  String get Type_msg {
    return Intl.message(
      'Type your message here...',
      name: 'Type_msg',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get Items {
    return Intl.message(
      'Items',
      name: 'Items',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get Download {
    return Intl.message(
      'Download',
      name: 'Download',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get Preview {
    return Intl.message(
      'Preview',
      name: 'Preview',
      desc: '',
      args: [],
    );
  }

  /// `No slides to display`
  String get no_slides_to_display {
    return Intl.message(
      'No slides to display',
      name: 'no_slides_to_display',
      desc: '',
      args: [],
    );
  }

  /// `Paid Books and Slides`
  String get paid_books_slides {
    return Intl.message(
      'Paid Books and Slides',
      name: 'paid_books_slides',
      desc: '',
      args: [],
    );
  }

  /// `Free Books and Slides`
  String get free_books_slides {
    return Intl.message(
      'Free Books and Slides',
      name: 'free_books_slides',
      desc: '',
      args: [],
    );
  }

  /// `Copy Type`
  String get Copy_type {
    return Intl.message(
      'Copy Type',
      name: 'Copy_type',
      desc: '',
      args: [],
    );
  }

  /// `Please Select the type of copy you want`
  String get select_the_copy_type {
    return Intl.message(
      'Please Select the type of copy you want',
      name: 'select_the_copy_type',
      desc: '',
      args: [],
    );
  }

  /// `Pick PDF File`
  String get pick_pdf {
    return Intl.message(
      'Pick PDF File',
      name: 'pick_pdf',
      desc: '',
      args: [],
    );
  }

  /// `Add file here`
  String get add_file {
    return Intl.message(
      'Add file here',
      name: 'add_file',
      desc: '',
      args: [],
    );
  }

  /// `File Name`
  String get file_name {
    return Intl.message(
      'File Name',
      name: 'file_name',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get Accept {
    return Intl.message(
      'Accept',
      name: 'Accept',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get Decline {
    return Intl.message(
      'Decline',
      name: 'Decline',
      desc: '',
      args: [],
    );
  }

  /// ` has requested to reserved your `
  String get request_your_item {
    return Intl.message(
      ' has requested to reserved your ',
      name: 'request_your_item',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Major`
  String get Major {
    return Intl.message(
      'Major',
      name: 'Major',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get About {
    return Intl.message(
      'About',
      name: 'About',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get payment {
    return Intl.message(
      'Payment method',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card`
  String get Credit_card {
    return Intl.message(
      'Credit Card',
      name: 'Credit_card',
      desc: '',
      args: [],
    );
  }

  /// `Validate`
  String get validate {
    return Intl.message(
      'Validate',
      name: 'validate',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get Pay {
    return Intl.message(
      'Pay',
      name: 'Pay',
      desc: '',
      args: [],
    );
  }

  /// `PayPal Checkout`
  String get PayPal_check {
    return Intl.message(
      'PayPal Checkout',
      name: 'PayPal_check',
      desc: '',
      args: [],
    );
  }

  /// `Credit card / Debit card`
  String get credit_card {
    return Intl.message(
      'Credit card / Debit card',
      name: 'credit_card',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get Cash_delivery {
    return Intl.message(
      'Cash on delivery',
      name: 'Cash_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Paypal`
  String get Paypal {
    return Intl.message(
      'Paypal',
      name: 'Paypal',
      desc: '',
      args: [],
    );
  }

  /// `Google Wallet`
  String get Google_wallet {
    return Intl.message(
      'Google Wallet',
      name: 'Google_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `You have selected Cash on Delivery. Your order will be delivered, and payment will be collected in cash.`
  String get cash_msg {
    return Intl.message(
      'You have selected Cash on Delivery. Your order will be delivered, and payment will be collected in cash.',
      name: 'cash_msg',
      desc: '',
      args: [],
    );
  }

  /// `You have selected Paypal payment method. click to continue payment and check it out.`
  String get paypal_msg {
    return Intl.message(
      'You have selected Paypal payment method. click to continue payment and check it out.',
      name: 'paypal_msg',
      desc: '',
      args: [],
    );
  }

  /// `Checkout 7₪ for delivery`
  String get Checkout {
    return Intl.message(
      'Checkout 7₪ for delivery',
      name: 'Checkout',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get Finish {
    return Intl.message(
      'Finish',
      name: 'Finish',
      desc: '',
      args: [],
    );
  }

  /// `What do you want to eat?`
  String get what_do_you_want_to_eat {
    return Intl.message(
      'What do you want to eat?',
      name: 'what_do_you_want_to_eat',
      desc: '',
      args: [],
    );
  }

  /// `Best Seller`
  String get best_seller {
    return Intl.message(
      'Best Seller',
      name: 'best_seller',
      desc: '',
      args: [],
    );
  }

  /// `Electronic Offers`
  String get Electronic_offers {
    return Intl.message(
      'Electronic Offers',
      name: 'Electronic_offers',
      desc: '',
      args: [],
    );
  }

  /// `Electricals Offers`
  String get Electricals_offers {
    return Intl.message(
      'Electricals Offers',
      name: 'Electricals_offers',
      desc: '',
      args: [],
    );
  }

  /// `Furniture Offers`
  String get Furniture_offers {
    return Intl.message(
      'Furniture Offers',
      name: 'Furniture_offers',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants Offers`
  String get Restaurants_offers {
    return Intl.message(
      'Restaurants Offers',
      name: 'Restaurants_offers',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get Review {
    return Intl.message(
      'Review',
      name: 'Review',
      desc: '',
      args: [],
    );
  }

  /// `Order Now`
  String get order_now {
    return Intl.message(
      'Order Now',
      name: 'order_now',
      desc: '',
      args: [],
    );
  }

  /// `Additional Notes:`
  String get Additional_Notes {
    return Intl.message(
      'Additional Notes:',
      name: 'Additional_Notes',
      desc: '',
      args: [],
    );
  }

  /// `Enter any special instructions...`
  String get Enter_special_instructions {
    return Intl.message(
      'Enter any special instructions...',
      name: 'Enter_special_instructions',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number:`
  String get Phone_Number {
    return Intl.message(
      'Phone Number:',
      name: 'Phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number...`
  String get Enter_phone_number {
    return Intl.message(
      'Enter your phone number...',
      name: 'Enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address:`
  String get Delivery_Address {
    return Intl.message(
      'Delivery Address:',
      name: 'Delivery_Address',
      desc: '',
      args: [],
    );
  }

  /// `Enter your delivery address...`
  String get Enter_delivery_address {
    return Intl.message(
      'Enter your delivery address...',
      name: 'Enter_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Time:`
  String get Delivery_Time {
    return Intl.message(
      'Delivery Time:',
      name: 'Delivery_Time',
      desc: '',
      args: [],
    );
  }

  /// `Total:`
  String get Total {
    return Intl.message(
      'Total:',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `Ratings and reviews`
  String get Ratings_reviews {
    return Intl.message(
      'Ratings and reviews',
      name: 'Ratings_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get Reviews {
    return Intl.message(
      'Reviews',
      name: 'Reviews',
      desc: '',
      args: [],
    );
  }

  /// `My points`
  String get My_points {
    return Intl.message(
      'My points',
      name: 'My_points',
      desc: '',
      args: [],
    );
  }

  /// `Sold items:`
  String get Sold_items {
    return Intl.message(
      'Sold items:',
      name: 'Sold_items',
      desc: '',
      args: [],
    );
  }

  /// `Discount:`
  String get Discount {
    return Intl.message(
      'Discount:',
      name: 'Discount',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Current Password`
  String get enter_current_password {
    return Intl.message(
      'Enter Current Password',
      name: 'enter_current_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enter_new_password {
    return Intl.message(
      'Enter New Password',
      name: 'enter_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirm_new_password {
    return Intl.message(
      'Confirm New Password',
      name: 'confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `What can we do to improve your experience?`
  String get improve_experience {
    return Intl.message(
      'What can we do to improve your experience?',
      name: 'improve_experience',
      desc: '',
      args: [],
    );
  }

  /// `Please take a moment to evaluate and tell\n us what you think.`
  String get take_moment {
    return Intl.message(
      'Please take a moment to evaluate and tell\n us what you think.',
      name: 'take_moment',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `Leftover meals`
  String get left_over_meal {
    return Intl.message(
      'Leftover meals',
      name: 'left_over_meal',
      desc: '',
      args: [],
    );
  }

  /// `What do you want to report?`
  String get reportDialogTitle {
    return Intl.message(
      'What do you want to report?',
      name: 'reportDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your report is anonymous, please write your problem and we will review it shortly.`
  String get reportAnonymousText {
    return Intl.message(
      'Your report is anonymous, please write your problem and we will review it shortly.',
      name: 'reportAnonymousText',
      desc: '',
      args: [],
    );
  }

  /// `Write your report here..`
  String get reportPlaceholder {
    return Intl.message(
      'Write your report here..',
      name: 'reportPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get Report {
    return Intl.message(
      'Report',
      name: 'Report',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for letting us know, Your feedback is important in helping us keep the community save.`
  String get thanksForLettingUsKnow {
    return Intl.message(
      'Thanks for letting us know, Your feedback is important in helping us keep the community save.',
      name: 'thanksForLettingUsKnow',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comment {
    return Intl.message(
      'Comments',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Cost`
  String get delivery_cost {
    return Intl.message(
      'Delivery Cost',
      name: 'delivery_cost',
      desc: '',
      args: [],
    );
  }

  /// `For the delivery cost, there is a charge of 7 NIS. To proceed, please click on Next.`
  String get delivery_cost_descrp {
    return Intl.message(
      'For the delivery cost, there is a charge of 7 NIS. To proceed, please click on Next.',
      name: 'delivery_cost_descrp',
      desc: '',
      args: [],
    );
  }

  /// `Hello how we can help you?`
  String get asset_you {
    return Intl.message(
      'Hello how we can help you?',
      name: 'asset_you',
      desc: '',
      args: [],
    );
  }

  /// `Click to start the Conversion`
  String get click_to_start {
    return Intl.message(
      'Click to start the Conversion',
      name: 'click_to_start',
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

import 'dart:ui';

class Global {
  static const String dateTimeFormatPattern = 'dd/MM/yyyy HH:mm';
  static const Set<String> supportedLocales = {'en'}; // add more locales here

  static String getLocale() => supportedLocales.contains(PlatformDispatcher.instance.locale.languageCode) ?
                                  PlatformDispatcher.instance.locale.languageCode :
                                  'en';
}

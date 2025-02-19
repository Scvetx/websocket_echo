// ignore_for_file: constant_identifier_names

class AppConst {
  AppConst._();

  static const HEADER_BASIC_AUTH_PREFIX = 'Basic';
  static const HEADER_PROTECTED_AUTHENTICATION_PREFIX = 'Bearer';
  static const HEADER_AUTHORIZATION = 'Authorization';
  static const HEADER_ACCEPT_LANGUAGE = 'accept-language';

  static const BASE_URL_DEV = 'https://dev.example.com';
  static const BASE_URL_PROD = 'https://example.com';

  static const WS_URL_PROD = 'wss://example.com/ws'; 

  static const WS_ECHO_PROD = 'wss://ws.ifelse.io';
}

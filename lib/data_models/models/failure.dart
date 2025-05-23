import 'dart:io';

import '/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../enums/data_source.dart';

class Failure {
  int code; // 200 or 400
  bool status; // 200 or 400
  String message; // error or success

  Failure({this.code = 200, this.message = "", this.status = true});
}

class ResponseCode {
  // API status codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorized = 401; // failure user is not authorised
  static const int notFound =
      404; // failure, api url is not correct and not found
  static const int internalServerError =
      500; // failure, crash happened in server side

  // local status code
  static const int defaultError = -1;
  static const int connecError = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status codes
  // API response codes
  static String success =
      AppLocalizations.of(activeContext)!.success; // success with data
  static String noContent =
      AppLocalizations.of(activeContext)!.noContent; // success with no content
  static String badRequestError = AppLocalizations.of(activeContext)!
      .badRequestError; // failure, api rejected our request
  static String forbiddenError = AppLocalizations.of(activeContext)!
      .forbiddenError; // failure,  api rejected our request
  static String unauthorizedError = AppLocalizations.of(activeContext)!
      .unauthorizedError; // failure, user is not authorised
  static String notFoundError = AppLocalizations.of(activeContext)!
      .notFoundError; // failure, API url is not correct and not found in api side.
  static String internalServerError = AppLocalizations.of(activeContext)!
      .internalServerError; // failure, a crash happened in API side.

  // local responses codes
  static String defaultError = AppLocalizations.of(activeContext)!
      .defaultError; // unknown error happened
  static String connectTimeout =
      AppLocalizations.of(activeContext)!.timeoutError; // issue in connectivity
  static String cancel = AppLocalizations.of(activeContext)!
      .defaultError; // API request was cancelled
  static String receiveTimeout = AppLocalizations.of(activeContext)!
      .timeoutError; //  issue in connectivity
  static String sendTimeout = AppLocalizations.of(activeContext)!
      .timeoutError; //  issue in connectivity
  static String cacheError = AppLocalizations.of(activeContext)!
      .defaultError; //  issue in getting data from local data source (cache)
  static String noInternetError = AppLocalizations.of(activeContext)!
      .noInternetError; // issue in connectivity
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(
            code: ResponseCode.badRequest,
            message: ResponseMessage.badRequestError.trim(),
            status: false);
      case DataSource.forbidden:
        return Failure(
            code: ResponseCode.forbidden,
            message: ResponseMessage.forbiddenError.trim(),
            status: false);
      case DataSource.unauthorised:
        return Failure(
            code: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorizedError.trim(),
            status: false);
      case DataSource.notFound:
        return Failure(
            code: ResponseCode.notFound,
            message: ResponseMessage.notFoundError.trim(),
            status: false);
      case DataSource.internalServerError:
        return Failure(
            code: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError.trim(),
            status: false);
      case DataSource.connectTimeout:
        return Failure(
            code: ResponseCode.connecError,
            message: ResponseMessage.connectTimeout.trim(),
            status: false);
      case DataSource.cancel:
        return Failure(
            code: ResponseCode.cancel,
            message: ResponseMessage.cancel.trim(),
            status: false);
      case DataSource.receiveTimeout:
        return Failure(
            code: ResponseCode.receiveTimeout,
            message: ResponseMessage.receiveTimeout.trim(),
            status: false);
      case DataSource.sendTimeoutT:
        return Failure(
            code: ResponseCode.sendTimeout,
            message: ResponseMessage.sendTimeout.trim(),
            status: false);
      case DataSource.cacheError:
        return Failure(
            code: ResponseCode.cacheError,
            message: ResponseMessage.cacheError.trim(),
            status: false);
      case DataSource.noInternetConnection:
        return Failure(
            code: ResponseCode.noInternetConnection,
            message: ResponseMessage.noInternetError.trim(),
            status: false);
      case DataSource.defaultError:
        return Failure(
            code: ResponseCode.defaultError,
            message: ResponseMessage.defaultError,
            status: false);
      default:
        return Failure(
            code: ResponseCode.defaultError,
            message: ResponseMessage.defaultError,
            status: false);
    }
  }
}

class AppExceptions implements Exception {
  late Failure failure;

  AppExceptions.handle(dynamic error) {
    if (error is HttpResponse) {
      failure = _handleException(error);
    } else {
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleException(HttpResponse error) {
    switch (error.statusCode) {
      case ResponseCode.connecError:
        return DataSource.connectTimeout.getFailure();
      case ResponseCode.sendTimeout:
        return DataSource.sendTimeoutT.getFailure();
      case ResponseCode.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();

      case ResponseCode.badRequest:
        return DataSource.badRequest.getFailure();
      case ResponseCode.forbidden:
        return DataSource.forbidden.getFailure();
      case ResponseCode.unauthorized:
        return DataSource.unauthorised.getFailure();
      case ResponseCode.notFound:
        return DataSource.notFound.getFailure();
      case ResponseCode.internalServerError:
        return DataSource.internalServerError.getFailure();

      case ResponseCode.cancel:
        return DataSource.cancel.getFailure();

      default:
        return DataSource.defaultError.getFailure();
    }
  }
}

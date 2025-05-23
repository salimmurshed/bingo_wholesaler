import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart';

enum Environment { qa, dev, prod }

class ConstantEnvironment {
  static Map<dynamic, dynamic>? config;
  static Environment? environments;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        environments = Environment.dev;
        config = Config.dev;
        break;
      case Environment.prod:
        environments = Environment.prod;
        config = Config.prod;
        break;
      case Environment.qa:
        environments = Environment.qa;
        config = Config.qa;
        break;
    }
  }

  static get baseUrl {
    return config!['baseURL'];
  }

  static get signupUrl {
    return config!['signupUrl'];
  }

  static get redirectBaseURL {
    return config!['redirectBaseURL'];
  }

  static get forgotUrl {
    return config!['forgotUrl'];
  }
}

p() {
  var url = window.location.host;
  print('url');
  print(url);
}

class Config {
  static Map<dynamic, dynamic> dev = {
    // 'baseURL': "http://api.bingosolutions.io/api/",
    // 'forgotUrl': "https://bingosolutions.io/partners/forgot_password.php",
    // 'signupUrl': "https://bingosolutions.io/partners/retailer_signup.php"
    // 'baseURL': "http://18.188.14.183/bingo_api/public/api/",
    'baseURL': "https://api.dev.bingosolutions.io/api/",
    'redirectBaseURL': (kDebugMode ? 'http://' : '') + window.location.host,

    // 'forgotUrl': "http://18.188.14.183/partners/forgot_password.php",
    // 'signupUrl': "http://18.188.14.183/partners/retailer_signup.php"
    // 'baseURL': "https://api.dev.bingosolutions.io/api/",
    'forgotUrl': "https://api.dev.bingosolutions.io/forgot_password.php",
    'signupUrl': "https://api.dev.bingosolutions.io/retailer_signup.php"
  };

  static Map<dynamic, dynamic> prod = {
    'baseURL': "http://api.bingosolutions.io/api/",
    'redirectBaseURL': "http://18.188.14.183/",
    'forgotUrl': "https://bingosolutions.io/partners/forgot_password.php",
    'signupUrl': "https://bingosolutions.io/partners/retailer_signup.php"
  };

  static Map<dynamic, dynamic> qa = {
    'baseURL': "http://100.27.47.144/api/",
    'redirectBaseURL': "http://18.188.14.183/",
    'forgotUrl': "https://qa.bingosolutions.io/partners/forgot_password.php",
    'signupUrl': "https://qa.bingosolutions.io/partners/retailer_signup.php"
  };
}

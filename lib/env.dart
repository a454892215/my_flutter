class EnvironmentConfig {
  static const APP_CHANNEL = String.fromEnvironment('APP_CHANNEL');
  static const APP_ENV = String.fromEnvironment('APP_ENV');

 static String getEnvInfo() {
    return '环境配置： APP_ENV:$APP_ENV  APP_CHANNEL: $APP_CHANNEL';
  }

}

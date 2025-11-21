enum EnvironmentConfig { staging, production }

abstract class Environment {
  String get firebaseId;
}

//for example
class StagingEnvironment implements Environment {
  @override
  String get firebaseId => "firebase id";
}

//for example
class ProductionEnvironment implements Environment {
  @override
  String get firebaseId => "firebase id";
}

getFireBaseId(EnvironmentConfig environmentConfig) {
  switch (environmentConfig) {
    case EnvironmentConfig.production:
      return ProductionEnvironment().firebaseId;
    case EnvironmentConfig.staging:
      return StagingEnvironment().firebaseId;
  }
}

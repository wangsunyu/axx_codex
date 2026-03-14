enum AppFlavor {
  test,
  prod,
}

class AppEnvironment {
  const AppEnvironment({
    required this.flavor,
    required this.scpsBaseUrl,
    required this.loginBaseUrl,
  });

  final AppFlavor flavor;
  final String scpsBaseUrl;
  final String loginBaseUrl;

  static const AppEnvironment test = AppEnvironment(
    flavor: AppFlavor.test,
    scpsBaseUrl: 'https://in.aiit.edu.cn/zhxy-new-scps/',
    loginBaseUrl: 'https://in.aiit.edu.cn/zhxy-information/',
  );

  static const AppEnvironment prod = AppEnvironment(
    flavor: AppFlavor.prod,
    scpsBaseUrl: 'https://in.aiit.edu.cn/zhxy-new-scps/',
    loginBaseUrl: 'https://in.aiit.edu.cn/zhxy-information/',
  );

  static const AppEnvironment current = test;
}

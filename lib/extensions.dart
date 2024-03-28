import 'constants.dart';

extension StringExt on String {
  String get svg {
    return "${Constants.gitlabBaseUrl}assets/svgs/$this.svg";
  }

  String get png {
    return "${Constants.gitlabBaseUrl}assets/images/$this.png";
  }

  String get url {
    return "${Constants.gitlabBaseUrl}$this";
  }
}

import 'constants.dart';

extension StringExt on String {
  String get svg {
    return "${Constants.gitlabBaseUrl}assets/svgs/$this.svg";
  }

  String get url {
    return "${Constants.gitlabBaseUrl}$this";
  }
}

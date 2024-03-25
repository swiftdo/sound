import './main.dart' deferred as origin_main;

void main(List<String> args) async {
  await origin_main.loadLibrary();
  origin_main.main();
}

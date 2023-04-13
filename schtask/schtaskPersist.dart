import 'dart:io';

void main() {
  final filePath = 'C:/file/path.exe';
  final obs = filePath.replaceAll("/", "\\");
  final minutes = 3;
  scheduleTask(obs, minutes, "MicrosoftEdge");
}

void scheduleTask(String filePath, int minutes, String taskName) async {
  final schtasksPath = 'schtasks.exe';
  final arguments = [
    '/create',
    '/sc',
    'MINUTE',
    '/mo',
    '$minutes',
    '/tn',
    taskName,
    '/tr',
    '"$filePath"'
  ];

  final process = await Process.run(schtasksPath, arguments);
  if (process.exitCode == 0) {
    print('Module Executed');
  } else {
    print('Add some code here to handle this kind of error');
  }
}

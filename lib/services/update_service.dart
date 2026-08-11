import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppUpdateInfo {
  final bool hasUpdate;
  final String currentVersion;
  final String latestVersion;
  final String? downloadUrl;
  final String? releaseNotes;

  const AppUpdateInfo({
    required this.hasUpdate,
    required this.currentVersion,
    required this.latestVersion,
    this.downloadUrl,
    this.releaseNotes,
  });
}

class UpdateService {
  static const String appVersion = '1.1.2';
  static const String repoOwner = 'gdatcu';
  static const String repoName = 'limpede';

  Future<AppUpdateInfo> checkForUpdates() async {
    const String releasesApiUrl =
        'https://api.github.com/repos/$repoOwner/$repoName/releases/latest';

    try {
      final response = await http.get(
        Uri.parse(releasesApiUrl),
        headers: {'Accept': 'application/vnd.github.v3+json'},
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String tagName = (data['tag_name'] as String? ?? '').replaceAll('v', '').trim();
        final String body = data['body'] as String? ?? '';
        final String htmlUrl = data['html_url'] as String? ?? '';

        String downloadUrl = htmlUrl;
        final List<dynamic> assets = data['assets'] as List<dynamic>? ?? [];
        for (var asset in assets) {
          final assetName = asset['name'] as String? ?? '';
          if (assetName.endsWith('.apk')) {
            downloadUrl = asset['browser_download_url'] as String? ?? htmlUrl;
            break;
          }
        }

        final isNewer = _isVersionNewer(tagName, appVersion);

        return AppUpdateInfo(
          hasUpdate: isNewer,
          currentVersion: appVersion,
          latestVersion: tagName.isNotEmpty ? tagName : appVersion,
          downloadUrl: downloadUrl,
          releaseNotes: body,
        );
      }
    } catch (e) {
      debugPrint('Update check notice: $e');
    }

    return const AppUpdateInfo(
      hasUpdate: false,
      currentVersion: appVersion,
      latestVersion: appVersion,
    );
  }

  static bool _isVersionNewer(String latest, String current) {
    if (latest.isEmpty || current.isEmpty) return false;
    try {
      final List<int> latestParts =
          latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
      final List<int> currentParts =
          current.split('.').map((e) => int.tryParse(e) ?? 0).toList();

      for (int i = 0; i < mathMax(latestParts.length, currentParts.length); i++) {
        final latestNum = i < latestParts.length ? latestParts[i] : 0;
        final currentNum = i < currentParts.length ? currentParts[i] : 0;

        if (latestNum > currentNum) return true;
        if (latestNum < currentNum) return false;
      }
    } catch (_) {}
    return false;
  }

  static int mathMax(int a, int b) => a > b ? a : b;

  Future<bool> launchUpdateUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching update URL: $e');
      return false;
    }
  }
}

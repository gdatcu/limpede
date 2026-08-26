import 'package:envied/envied.dart';

part 'env_service.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(
    varName: 'SUPABASE_URL',
    defaultValue: 'https://wogfgbdzonvaavytxtpb.supabase.co',
    optional: true,
  )
  static const String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(
    varName: 'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvZ2ZnYmR6b252YWF2eXR4dHBiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU5NDQ0OTQsImV4cCI6MjEwMTUyMDQ5NH0.QN4O0G-u2stkoYslXMMYC1xiajF2W7rQMkXtYKhOa6U',
    optional: true,
  )
  static const String supabaseAnonKey = _Env.supabaseAnonKey;
}

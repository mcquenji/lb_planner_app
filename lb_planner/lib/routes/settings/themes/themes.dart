part of lbplanner_routes;

/// Themes settings.
class SettingsThemes extends LocalizedWidget {
  /// Themes settings.
  const SettingsThemes({Key? key}) : super(key: key);

  @override
  Widget build(context, t) {
    return LpContainer(
      title: t.settings_themes,
      height: double.infinity,
      child: Align(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: NcSpacing.mediumSpacing,
            runSpacing: NcSpacing.mediumSpacing,
            children: [
              for (var theme in NcThemes.all.values) SettingsThemesThemeItem(theme: theme),
            ],
          ),
        ),
      ),
    );
  }
}

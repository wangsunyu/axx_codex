## ADDED Requirements

### Requirement: iOS and Android target support
The project SHALL include working iOS and Android host platform configurations that are connected to the shared Flutter application entrypoint.

#### Scenario: Run mobile targets
- **WHEN** a developer runs the project on iOS or Android using the documented commands
- **THEN** the shared Flutter application launches through the corresponding native host project

### Requirement: HarmonyOS integration path
The project SHALL define a HarmonyOS-compatible integration path for the Flutter application, including required platform files, plugin strategy, and build entry instructions.

#### Scenario: Prepare HarmonyOS host
- **WHEN** a developer follows the HarmonyOS setup guidance in the repository
- **THEN** they can generate or maintain the HarmonyOS-side project structure needed to host the shared Flutter application

### Requirement: Platform-specific configuration boundaries
The project SHALL separate shared Flutter code from platform-specific configuration so platform changes do not require restructuring the shared application layer.

#### Scenario: Change platform configuration independently
- **WHEN** a maintainer updates a platform build setting or signing placeholder
- **THEN** the shared Dart application structure remains unchanged

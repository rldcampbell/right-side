# Running Right Side On iPhone

This guide explains how to build and run Right Side locally using Xcode.

## Requirements

- macOS with Xcode installed.
- The Xcode license agreement accepted.
- iOS 17 or later as the deployment target.
- For simulator builds: an installed iPhone Simulator runtime.
- For physical iPhone builds: an Apple Developer account, an iPhone running iOS 17 or later, and a valid signing team in Xcode.

## Clone The Repository

```sh
git clone <repository-url>
cd right-side
open RightSide.xcodeproj
```

## Confirm Xcode Is Ready

Open Xcode at least once and complete any first-launch setup.

To check command line build readiness:

```sh
xcodebuild -version
```

If Xcode reports that the license has not been accepted, review and accept it:

```sh
sudo xcodebuild -license
```

## Run In The iPhone Simulator

An Apple Developer account is not required for simulator-only development.

In Xcode:

1. Select the `RightSide` scheme.
2. Choose an iPhone Simulator as the run destination.
3. Press Run.

From the command line, a simulator build can be run with:

```sh
xcodebuild \
  -project RightSide.xcodeproj \
  -scheme RightSide \
  -destination 'generic/platform=iOS Simulator' \
  build
```

To run on a specific simulator device instead, replace the destination with an installed simulator name.

## Configure Signing For A Physical iPhone

In Xcode:

1. Select the project in the left navigator.
2. Select the `RightSide` target.
3. Open `Signing & Capabilities`.
4. Keep `Automatically manage signing` enabled.
5. Select an Apple Developer Team.

The project does not commit a development team ID. Xcode may update local project settings after a team is selected.

## Bundle Identifier

If Xcode reports that the configured bundle identifier is unavailable, change it in `Signing & Capabilities` to a unique reverse-DNS identifier associated with the selected developer account.

Example:

```text
com.yourname.rightside
```

## Prepare The iPhone

1. Connect the iPhone to the Mac.
2. Unlock the iPhone and trust the Mac if prompted.
3. Enable Developer Mode if iOS requires it.
4. In Xcode, open `Window > Devices and Simulators`.
5. Confirm the iPhone appears and finishes any preparation step.

Developer Mode can be enabled on the iPhone in `Settings > Privacy & Security > Developer Mode`. The device may need to restart.

## Run On The iPhone

In Xcode:

1. Select the `RightSide` scheme.
2. Select the connected iPhone as the run destination.
3. Press Run.

Xcode will build, sign, install, and launch the app. The first device build can take longer while Xcode prepares the device and creates signing assets.

## First Launch

Right Side starts with no built-in prompts.

Suggested first check:

1. Add a short prompt.
2. Save it.
3. Open the `Draw` tab.
4. Tap `Draw a card`.

With one saved prompt, the same card can be drawn repeatedly. With multiple prompts, the v1 selection rule avoids the most recently shown 50% of prompts when possible.

## Troubleshooting

If Xcode cannot create a provisioning profile:

- Confirm an Apple Developer Team is selected.
- Confirm the bundle identifier is unique.
- Confirm the connected iPhone can be used for development by the selected team.

If the iPhone does not appear in Xcode:

- Reconnect the device.
- Unlock the device.
- Confirm the Mac is trusted on the device.
- Open `Window > Devices and Simulators` and wait for preparation to finish.

If the app installs but does not launch:

- Confirm the device is running iOS 17 or later.
- Confirm Developer Mode is enabled.
- Run `Product > Clean Build Folder`, then build again.

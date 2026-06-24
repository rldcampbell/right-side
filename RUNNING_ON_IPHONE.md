# Running Right Side On Your iPhone

This guide is for running the app locally from your personal Mac using your Apple Developer subscription.

## Can We Run It On This Work Machine?

Possibly in the iPhone Simulator, but not cleanly right now.

This work machine has Xcode installed, but command line builds are currently blocked until the Xcode licence is accepted. The project source has been type-checked against the iPhone Simulator SDK, but a full `xcodebuild` run is not currently available here.

To run on this work machine later:

1. Open Xcode once, or run `sudo xcodebuild -license` in Terminal if permitted.
2. Open `RightSide.xcodeproj`.
3. Select an iPhone Simulator.
4. Press Run.

Running on a physical personal iPhone is better done from your personal Mac, because that is where your Apple ID, developer account, device trust, and signing setup belong.

## Personal Mac Prerequisites

- A personal Mac with Xcode installed.
- Your Apple ID signed into Xcode.
- An active Apple Developer subscription.
- Your personal iPhone running iOS 17 or later.
- The iPhone connected by USB for the first run, or already paired for wireless development.

## 1. Clone The Repo

After you create a remote and push this repo from the work machine, clone it on your personal Mac:

```sh
git clone <your-remote-url>
cd right-side
```

Open the project:

```sh
open RightSide.xcodeproj
```

## 2. Sign Into Xcode

In Xcode:

1. Open `Xcode > Settings`.
2. Go to `Accounts`.
3. Add your Apple ID if it is not already there.
4. Confirm your paid developer team appears under the account.

## 3. Select The App Target

In Xcode:

1. Select the project in the left navigator.
2. Select the `RightSide` target.
3. Open `Signing & Capabilities`.
4. Leave `Automatically manage signing` enabled.
5. Choose your personal Apple Developer Team.

The project intentionally does not commit a development team ID.

Xcode may modify `RightSide.xcodeproj/project.pbxproj` when you choose a team. That is normal locally. Before pushing future commits, check whether you want to keep or discard personal signing changes.

## 4. Check The Bundle Identifier

The current bundle identifier is:

```text
com.robertcampbell.rightside
```

If Xcode reports that the identifier is unavailable, change it in `Signing & Capabilities` to something unique to your developer account, for example:

```text
com.<yourname>.rightside
```

## 5. Prepare The iPhone

Connect the iPhone to the Mac.

On the iPhone:

1. Trust the Mac if iOS asks.
2. Enable Developer Mode if prompted.
3. If Developer Mode is not already enabled, go to `Settings > Privacy & Security > Developer Mode`, enable it, and restart the iPhone when asked.

In Xcode:

1. Open `Window > Devices and Simulators`.
2. Confirm the iPhone appears and is paired.
3. Wait for Xcode to finish any device preparation step.

## 6. Run The App

In the Xcode toolbar:

1. Select the `RightSide` scheme.
2. Select your iPhone as the run destination.
3. Press the Run button.

The first build may take a little while. If signing is correct, Xcode will install and launch Right Side on the iPhone.

## First Launch

The app should open to prompt creation because there are no saved prompts yet.

Try this flow:

1. Add one short prompt.
2. Save it.
3. Go to `Draw`.
4. Tap `Draw a card`.

With only one prompt, the app can draw the same prompt repeatedly. Once you add more prompts, the v1 recency rule avoids the most recently shown 50% when possible.

## Common Fixes

If Xcode says it cannot create a provisioning profile:

- Confirm your paid developer team is selected.
- Confirm the bundle identifier is unique.
- Confirm the iPhone is registered or available to your developer team.

If the iPhone does not appear:

- Reconnect by USB.
- Unlock the phone.
- Trust the Mac on the phone.
- Open `Window > Devices and Simulators` and wait.

If the app installs but will not launch:

- Confirm the iPhone is on iOS 17 or later.
- Confirm Developer Mode is enabled.
- Try cleaning the build folder with `Product > Clean Build Folder`, then Run again.

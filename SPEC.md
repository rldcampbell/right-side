# Right Side: V1 App Spec

## Purpose

Right Side is a small native iPhone app for drawing a simple personal prompt: something the user has chosen because it may help them begin, reset, or tilt the day in a better direction.

The app should feel quiet, personal, and low-friction. It is not a habit tracker, streak engine, productivity system, or content library. Version 1 is intentionally local, simple, and user-authored.

## Version 1 Scope

### Platform

- Native iPhone app only.
- SwiftUI UI.
- SwiftData persistence.
- iOS 17 or later.
- Apple frameworks only unless a compelling technical reason appears later.
- Standard Xcode project suitable for opening on a personal Mac and running on a personal iPhone via an Apple Developer account.

### Local-Only Requirements

- Store all data locally on the device.
- No accounts.
- No iCloud sync.
- No backend.
- No network access.
- No analytics.
- No diagnostics collection.

### Explicitly Out of Scope

- iPad support.
- Mac support.
- Categories.
- Search.
- Built-in prompts.
- Notifications or reminders.
- Widgets.
- Siri shortcuts.
- Live Activities.
- Onboarding or tutorial screens beyond first-use add prompt flow.
- Completion or done actions.
- Streaks, scoring, gamification, or progress metrics.
- Rich text, links, attachments, audio, images, or media.

## App Structure

Version 1 should use a simple native tab layout with two tabs:

- `Draw`
- `Prompts`

`Draw` is the primary experience. `Prompts` is where the user manages the source list.

If there are no prompts, the app should guide the user straight to adding the first prompt. The Draw experience should not need to handle a full empty state in version 1 beyond being unavailable or redirecting to prompt creation.

## Prompt Model

Each prompt is plain text only.

### Text Rules

- Maximum prompt length: 140 characters.
- Empty or whitespace-only prompts are invalid.
- Prompt text should be presented as user-authored content, not as tasks imposed by the app.

### Stored Fields

Each prompt should store:

- Stable ID.
- Prompt text.
- Creation date.
- Last edited date.
- Last shown date, nullable.
- Total shown count.
- Theme assignment.

The original creation date should remain unchanged when a prompt is edited. Editing should update the last edited date.

The model should stay simple for v1, but should not make a future category feature unnecessarily hard to add.

## Prompt Management

The `Prompts` tab should allow the user to:

- Add a new prompt.
- View saved prompts.
- Edit an existing prompt.
- Delete an existing prompt.

Prompt list behavior:

- Sort prompts by creation date.
- Keep the order fixed when a prompt is edited.
- Use a compact row style by default.
- Rows may show an ellipsized preview of longer prompt text.
- Allow expansion or navigation so the full prompt can be read.
- No search in v1.

Deletion:

- Deleted prompts are permanently removed.
- No archive.
- No undo requirement for v1.

## Draw Experience

The `Draw` tab should show one card at a time.

Behavior:

- The main action button text is `Draw a card`.
- Drawing immediately replaces the currently shown card.
- The button/action should feel deliberate and hard to trigger accidentally.
- No confirmation step.
- The last drawn card should remain visible until another card is drawn.
- The last drawn card should survive app restarts.
- No history view in v1.

When a card is drawn:

- Select an eligible prompt at random.
- Set that prompt's last shown date to the current date/time.
- Increment that prompt's shown count.
- Persist the selected prompt as the last drawn card.

## Random Selection Rule

The app should avoid recently shown prompts when possible.

Version 1 uses a hardcoded 50% recency exclusion rule:

1. Let `N` be the number of saved prompts.
2. Let `excludedCount = floor(N * 0.5)`.
3. Sort prompts with a `lastShownDate` by most recently shown first.
4. Exclude the first `excludedCount` prompts from the random draw.
5. Randomly select from the remaining eligible prompts.
6. If no eligible prompts remain for any reason, fall back to selecting from all prompts.

Examples:

- 1 prompt: `floor(0.5) = 0`, so the single prompt can be drawn.
- 2 prompts: exclude the 1 most recently shown prompt when possible.
- 5 prompts: exclude the 2 most recently shown prompts when possible.

Prompts that have never been shown should remain eligible.

## Visual Design

The app should use standard iOS controls and system typography for most interface elements.

The drawn card is the expressive part of the app:

- Prompt text should use a built-in Apple serif style, aiming for a literary feel close to Mrs Eaves without bundling a custom font.
- Card decoration should be generated locally.
- Decoration should be deterministic from the prompt/card ID, so a card keeps a recognizable visual identity.
- Each card should receive a theme automatically when created and keep it permanently.
- Use a small fixed palette of system-friendly themes.
- Users do not choose colours in v1.
- The card should have a muted base background colour that works in light and dark mode.
- Decoration should use large, soft, translucent overlapping circles around the card edges.
- Circles should not encroach on or reduce legibility of the central prompt text.
- The interface should follow the system light/dark appearance.

## Tone

Right Side should feel:

- Personal.
- Calm.
- Slightly delightful.
- Lightweight.
- Non-judgmental.

It should avoid:

- Productivity pressure.
- Motivational cliches.
- Gamified obligation.
- Excessive explanation.
- Visual clutter.

## Development Workflow Note

The repository should avoid committing personal Apple Developer signing configuration.

Expected workflow:

- Develop and commit source on this managed work laptop when convenient.
- Pull the repo on a personal Mac.
- Open the Xcode project on the personal Mac.
- Select the personal Apple Developer Team in Xcode signing settings.
- Run the app locally on the personal iPhone.

The project should be kept simple and clear enough for a first-time Swift native app workflow with Codex assistance.

# Spirit of Hope — Mobile App

Standing context for this repository. Read in full at the start of every session, before touching code. Everything here applies to every task unless a task prompt explicitly overrides it.

---

## 1. What this is

A Flutter mobile app (Android + iOS) for **Spirit of Hope Home Health Care**, an independently owned, non-medical in-home care agency serving four Maryland counties: Howard, Anne Arundel, Montgomery, and Baltimore.

It is a companion to the existing website, spiritofhopes.com, and does four things:

1. **Home safety assessment** — a 12-question self-assessment, ported from the website
2. **Consultation booking** — request a free, no-obligation consultation
3. **Blog** — articles published on the website appear automatically in the app
4. **AI support assistant** — chat that answers questions about services

Agency phone number, used throughout: **240-423-3099**

## 2. Who uses it

- **Older adults** researching care for themselves
- **Adult children**, roughly 45–65, researching care for a parent — often stressed, often in a hurry, sometimes at the point of crisis

Design for someone holding the phone at arm's length, possibly without reading glasses, possibly upset. Accessibility here is a functional requirement, not a polish pass. Section 6 is binding.

## 3. Architecture

There is **no Firebase, no Supabase, and no separate backend service.** The backend is the existing Wix Velo site.

```
Flutter app  ──HTTPS──>  https://www.spiritofhopes.com/_functions/*
                              │
                              ├── Wix Data collections
                              ├── Wix Blog
                              ├── Klaviyo API
                              └── Anthropic API (chat)
```

**There are no user accounts and no login.** Every feature works anonymously. Do not add authentication, user profiles, or sign-up. If a task appears to require a logged-in user, stop and ask — it almost certainly means the task has been misread.

A locally generated `sessionId` (UUID in `shared_preferences`) identifies a device for chat continuity only. It is not an identity and is never shown to the user as an account.

### API contract

Base URL: `https://www.spiritofhopes.com/_functions`
Preview base URL: `https://www.spiritofhopes.com/_functions-dev`

| Method | Path | Purpose |
|---|---|---|
| POST | `/chat` | Send a chat message, receive reply |
| GET | `/posts` | Paginated blog post list |
| GET | `/post` | Single blog post by slug |
| POST | `/assessment` | Submit completed assessment |
| POST | `/booking` | Submit consultation request |

New endpoints return:

```json
{ "ok": true, "data": { ... } }
{ "ok": false, "error": "human-readable message" }
```

`/chat` already exists in production and returns `{ ok, reply, sessionId }`. **Do not change its shape** — the website's chat widget depends on it.

## 4. Stack

- Flutter stable, Dart 3
- State: `flutter_riverpod`
- HTTP: `dio`, behind a single typed API client — no raw HTTP calls inside widgets
- Local storage: `shared_preferences`
- Blog HTML rendering: `flutter_widget_from_html`
- Images: `cached_network_image`
- Phone/email links: `url_launcher`
- Fonts: Inter Tight (brand), Geist Mono (small uppercase labels only)

Before adding any dependency not listed here, stop and ask.

Verify font availability before writing font code. Inter Tight is on Google Fonts. Geist Mono may need bundling as a local asset — check rather than assume.

## 5. Design tokens

Confirmed brand palette. Do not invent colours and do not add a dark theme.

| Token | Value | Use |
|---|---|---|
| `primaryGreen` | `#00544A` | Primary buttons, headers, key accents |
| `secondaryGrey` | `#ECECEC` | Secondary buttons, dividers, subtle fills |
| `accentYellow` | `#FFDA44` | **Icons and links only.** Never large blocks or backgrounds |
| `surface` | `#FFFFFF` | Default background |
| `surfaceAlt` | `#FAFBFA` | Alternating sections |
| `ink` | `#1F2933` | Body text |
| `inkMuted` | `#5B6670` | Secondary text |

Layouts are white and light. The audience is elderly; dark-heavy screens are wrong for this product. Dark mode is out of scope — if a task implies one, ask first.

Typography: Inter Tight throughout. Geist Mono reserved for small uppercase labels (eyebrow text, category tags), nothing else.

## 6. Accessibility requirements (binding)

Acceptance criteria on every screen, not a final pass.

- **Body text minimum 18sp**, captions minimum 15sp. Never 12–14sp for anything a user must read.
- **Tap targets minimum 56×56dp** — deliberately above the usual 48dp.
- **200% text scaling must not break any layout.** Test it. Use `Flexible`/`Expanded`; avoid fixed heights around text.
- **Contrast 4.5:1 minimum**, 7:1 preferred for body text.
- **Never rely on colour alone** to convey meaning — pair with text or an icon.
- Every interactive element carries a semantic label.
- A **"Call us" action is always reachable.** A user who gives up on the app should be one tap from a phone call.

## 7. Content and safety rules

The agency is **non-medical**. These apply to app copy and to anything the assistant says:

- **Never state a price, rate, or dollar figure anywhere.** The website deliberately has none. Pricing is "discussed during the free consultation."
- **Never give medical, clinical, or diagnostic advice.**
- **Never collect health details, diagnoses, medications, or medical history** in any field. Intake stays categorical (dropdowns), never open-ended health narrative. This boundary is deliberate and keeps the app outside HIPAA scope. If a task appears to ask for a freeform "describe your loved one's condition" field, stop and ask.
- Emergencies → tell the user to call 911.
- Do not invent service details, staff names, credentials, availability, or statistics. If copy is missing, leave an obvious `TODO:` and report it. Never fill a gap with plausible-sounding text.

## 8. Code conventions

```
lib/
  main.dart
  app.dart                 # MaterialApp, theme, routing
  core/
    theme/                 # tokens, typography, component themes
    api/                   # dio client, endpoints, error types
    models/
    utils/
  features/
    home/
    blog/
    assessment/
    booking/
    chat/
  shared/
    widgets/               # buttons, cards, loading/error/empty states
wix-backend/               # Velo source, copy-pasted into Wix (not compiled here)
```

- One feature per folder; its widgets, providers, and models live with it.
- No business logic in `build` methods.
- No hardcoded strings, colours, or text styles in widgets — colours and styles from the theme, copy from a constants file.
- Every network call has explicit loading, error, and empty states. A spinner with no failure path is not acceptable.
- Guard external data before use. Never assume a field exists in an API response.
- Keep edits surgical. Change what the task asks for; do not reformat or restructure unrelated code.

## 9. Working agreement

- **Ask, don't assume.** If a spec is ambiguous, a field unspecified, or behaviour undefined, stop and ask one direct question. Do not pick a silent default and mention it afterwards.
- **One segment at a time.** Do not start work from a later segment because it looks related.
- **Run `flutter analyze` before declaring a segment done.** Zero warnings.
- **Commit per logical unit** with clear messages. Do not bundle a whole segment into one commit.
- If something in this file is wrong or outdated, say so rather than coding around it.

## 10. Definition of done (every segment)

1. `flutter analyze` passes with zero warnings
2. App builds and runs on an Android emulator and an iOS simulator
3. Every new screen checked at 100% and 200% text scale
4. Every network call has loading, error, and empty states
5. No hardcoded colours, text styles, or magic numbers
6. No unexplained `TODO` left behind — any remaining one is reported

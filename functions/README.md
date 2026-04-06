# Cloud Functions

Firebase Cloud Functions for NutriSnap.

## Setup

```bash
cd functions
npm install
```

## Functions

| Function | Trigger | Purpose |
|---|---|---|
| `onMealPhotoUploaded` | Storage finalize | Vision + Gemini AI pipeline |
| `onMealWritten` | Firestore onWrite | Update daily summaries |
| `generateMealPlan` | HTTPS callable | Gemini meal plan generation |
| `generateWeeklySummary` | Scheduled (Sunday) | Aggregate weekly data |
| `sendMealReminders` | Scheduled | FCM push notifications |

## Deploy

```bash
npm run build
firebase deploy --only functions
```

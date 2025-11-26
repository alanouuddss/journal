# Journali (SwiftUI)

Journali is a personal journaling app built with SwiftUI.  
It allows users to create, edit, bookmark, search, and organize journal entries with a clean and modern UI.

## Features
- Create, edit, and delete journal entries
- Bookmark favorite entries
- Search through titles & content
- Sort by bookmark or date
- Elegant card-based list view
- Full-screen editor with autosave
- Custom swipe actions
- Splash screen with animation
- Local storage using `AppStorage` + JSON encoding
- Optional audio recording attachment (AVFoundation)

## Technologies Used
- SwiftUI
- NavigationStack
- AVFoundation (Audio Recording)
- AppStorage for persistence
- Codable models for local storage
- UltraThinMaterial UI effects
- Custom components & animations

## Project Structure
- `Item2` – journal entry model (title, content, date, bookmark, audio)
- `Intro2` – main journal list with search & sort
- `Editor2` – full-screen editor for writing
- `Card2` – journal card UI
- `Splash2` – animated launch screen
- `AudioRecorder2` – audio recording utility
- `JournalApp` – app entry point

## Notes
The app is designed with a focus on simplicity, smooth animations,  
and a clean writing experience while keeping everything stored

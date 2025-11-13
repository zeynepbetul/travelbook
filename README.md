# TravelBook

**TravelBook** is an iOS application that lets you save the places you visit by pinning them on an interactive map.  
You can store details such as the **place name**, **comment**, and **location coordinates**, and later view them directly on the map.

---

## Features

- **Pin Locations:** Long press anywhere on the map to pin a location.
- **Add Details:** Save a title and comment for each pinned place.
- **Persistent Storage:** All data is saved locally using **Core Data**.
- **Map Integration:** Built with **MapKit** to visualize locations interactively.
- **Location Tracking:** Uses **CoreLocation** to detect and center on the user’s current location.
- **Open in Apple Maps:** Tap a saved location to open driving directions in Apple Maps.

---

## Technologies Used

- **Swift (UIKit)** – Main programming language and UI framework  
- **MapKit** – Displays and interacts with maps and annotations  
- **CoreLocation** – Accesses the user’s real-time location  
- **CoreData** – Stores place information persistently  
- **NotificationCenter** – Updates the list view after saving new places  

---

## Usage Guide

1. **Add a new place:**
   - Tap the ➕ button on the list screen.
   - Long press (3 seconds) on the desired location on the map to drop a pin.
   - Enter a name and comment for the place.
   - Tap “Save” to store it in the app.

2. **View saved places:**
   - All saved places appear in a list.
   - Select any place to see it on the map again.

3. **Get directions:**
   - Tap on a pin’s info button to open driving directions in Apple Maps.

---

## Image


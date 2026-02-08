# App Icon Setup

## Quick Setup

1. **Create your app icon** (1024x1024 PNG with transparent background recommended)
   - Use the AAKAR logo design (green "a" + white "akar" on black/transparent background)
   - Save as `app_icon.png` in this folder

2. **Generate icons automatically**:
   ```bash
   cd d:\Study\practice\AKAAR\aakar_app
   flutter pub get
   flutter pub run flutter_launcher_icons
   ```

3. **Rebuild the app**:
   ```bash
   flutter run
   ```

## Design Recommendations

Based on your logo:
- **Background**: Black (#000000) or transparent
- **Text**: "aakar" in white
- **Accent**: Green "a" (#00FF00 or similar)
- **Size**: 1024x1024 pixels (will be auto-resized)
- **Format**: PNG with transparency

## Manual Creation Options

### Option 1: Use an online tool
- Visit: https://www.canva.com/create/logos/
- Or: https://www.figma.com/
- Create 1024x1024 design with your logo
- Export as PNG

### Option 2: Use image editor
- Photoshop, GIMP, or Paint.NET
- Canvas: 1024x1024 pixels
- Add your "aakar" text with green accent
- Export as PNG

### Option 3: Simple placeholder (temporary)
For now, you can use a solid color icon:
- Create a 1024x1024 PNG
- Green background with "A" text
- Save as `app_icon.png`

## Current Configuration

The app is configured to use:
- **Android**: Adaptive icon with black background
- **iOS**: Standard rounded icon
- **Image**: `assets/icon/app_icon.png`

Once you add `app_icon.png`, run the generator command above!

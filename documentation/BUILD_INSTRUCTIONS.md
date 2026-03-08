# Build Instructions - Split & Merge PDF Android Fix

## What Was Fixed

### 1. **Split PDF MissingPluginException**
- **Issue**: The `splitPdf` method was not implemented in the native Android layer
- **Solution**: 
  - Added `PdfManipulationHandler.kt` class with native `splitPdf`, `mergePdfs`, and `getPageCount` implementations
  - Updated `MainActivity.kt` to register the PDF manipulation method channel
  - Added PdfBox library dependency for PDF manipulation

### 2. **Storage Permission Handling**
- **Issue**: App showed "Storage permission denied, Attempting to proceed..." but didn't properly check permissions
- **Solution**:
  - Added explicit permission checks before split/merge operations
  - Improved error messages to distinguish between different failure scenarios
  - Added specific error handling for MissingPluginException, Permission denied, and File not found errors

### 3. **Android Gradle Dependencies**
- **Added**: Apache PdfBox 3.0.1 and related libraries for PDF manipulation on Android

## Files Modified

1. **android/app/build.gradle.kts**
   - Added PdfBox and support dependencies

2. **android/app/src/main/kotlin/com/ahsmobilelabs/openpdf_tools/MainActivity.kt**
   - Registered PDF Manipulation method channel
   - Initialized PdfManipulationHandler

3. **android/app/src/main/kotlin/com/ahsmobilelabs/openpdf_tools/PdfManipulationHandler.kt** (NEW)
   - Implements native PDF operations using Apache PdfBox
   - Methods: `mergePdfs`, `splitPdf`, `getPageCount`

4. **lib/screens/merge_pdf_screen.dart**
   - Added permission check before merge operation
   - Improved error messages

5. **lib/screens/split_pdf_screen.dart**
   - Added permission check before split operation
   - Improved error messages

## How to Rebuild

### Option 1: Clean Rebuild (Recommended)
```bash
# Clean build artifacts
flutter clean

# Get dependencies
flutter pub get

# Run the app
flutter run
```

### Option 2: Quick Rebuild
```bash
# Just run the app (will rebuild as needed)
flutter run
```

### For Android Gradle Sync Issues
If you encounter gradle sync issues in Android Studio:
1. Open Android Studio
2. Go to **File → Sync Now**
3. Wait for dependencies to download (may take several minutes)
4. Run the app again from VS Code or Android Studio

## Testing

After rebuild, test the following:

### Split PDF Feature
1. Navigate to "Split PDF" screen
2. Select a multi-page PDF file
3. Choose "Extract All Pages Separately"
4. Tap "Split PDF"
5. **Expected**: PDF splits into individual page files

### Merge PDF Feature
1. Navigate to "Merge PDFs" screen
2. Select 2 or more PDF files
3. Tap "Merge PDFs"
4. **Expected**: PDFs merge into a single file

### Permission Handling
- If you deny storage permission when requested, the app should show a clear error message
- Re-run the operation after granting permission

## Troubleshooting

### Issue: Still Getting MissingPluginException
**Solution**: 
- Make sure you ran `flutter clean` before rebuilding
- The PdfManipulationHandler.kt file needs to be in the same package as MainActivity.kt
- Verify the gradle sync completed successfully

### Issue: Build fails with dependency issues
**Solution**:
- Run `flutter pub get` again
- Check that you have internet connection for downloading gradle dependencies
- Try clearing gradle cache: `rm -rf ~/.gradle/caches`

### Issue: App crashes after rebuild
**Solution**:
- Check the Android logcat output: `flutter logs`
- Verify storage permissions are granted in app settings
- Try reinstalling: `flutter run --clean`

## Dependencies Added

```
org.apache.pdfbox:pdfbox:3.0.1
org.apache.pdfbox:fontbox:3.0.1
org.apache.commons:commons-io:1.3.2
androidx.appcompat:appcompat:1.6.1
androidx.core:core:1.13.1
```

These are Apache's industry-standard PDF manipulation libraries that handle:
- Merging multiple PDFs
- Splitting PDFs into individual pages
- Extracting specific page ranges
- Reading PDF metadata (page count, etc.)

## Additional Notes

- Both merge and split operations use temporary directories for outputs
- Large PDF files (>100 MB per file) may take longer to process
- The app gracefully handles missing files and invalid page ranges
- All error messages now indicate the specific cause of failures

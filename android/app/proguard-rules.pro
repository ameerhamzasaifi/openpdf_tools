# ── Flutter ──────────────────────────────────────────────────────────────────
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }

# ── App ───────────────────────────────────────────────────────────────────────
-keep class com.ahsmobilelabs.openpdf_tools.** { *; }

# ── Apache PDFBox ─────────────────────────────────────────────────────────────
-keep class org.apache.pdfbox.** { *; }
-keep class org.apache.fontbox.** { *; }
-keep class org.apache.commons.logging.** { *; }

# Suppress warnings about desktop/AWT classes not present on Android
-dontwarn java.awt.**
-dontwarn javax.imageio.**
-dontwarn javax.swing.**
-dontwarn javax.servlet.**
-dontwarn org.apache.log.**
-dontwarn org.apache.log4j.**
-dontwarn org.apache.avalon.**
-dontwarn org.apache.commons.logging.impl.Log4JLogger
-dontwarn org.apache.commons.logging.impl.ServletContextCleaner
-dontwarn org.bouncycastle.**

# ── Android standard rules ────────────────────────────────────────────────────
-keepclasseswithmembernames class * { native <methods>; }
-keepclassmembers class * extends java.lang.Enum { <init>(...); }
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
-keep class * implements java.io.Serializable {
    static final long serialVersionUID;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# ── General warnings ──────────────────────────────────────────────────────────
-dontwarn javax.annotation.**
-dontwarn org.checkerframework.**
-dontwarn com.google.android.play.core.**
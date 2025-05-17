# ===========================
# ✅ Core Flutter rules
# ===========================
# -keep class io.flutter.embedding.** { *; }
# -keep class io.flutter.plugin.** { *; }
# -keep class io.flutter.plugins.** { *; }
# -keep class io.flutter.view.** { *; }
# -keep class io.flutter.app.** { *; }
# -keep class io.flutter.util.** { *; }
# -ignorewarnings

-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-ignorewarnings

# ===========================
# ✅ Gson rules
# ===========================
-keepattributes Signature, *Annotation*
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

-keepclassmembers,allowobfuscation class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

# ===========================
# ✅ Firebase (Analytics, Crashlytics, etc.)
# ===========================
-keep class com.google.firebase.** { *; }
-keep class com.firebase.** { *; }
-keepattributes SourceFile, LineNumberTable, *Annotation*, EnclosingMethod, InnerClasses
-keep public class * extends java.lang.Exception

# ===========================
# ✅ Crashlytics recommended rules
# ===========================
-renamesourcefileattribute SourceFile
-keepattributes SourceFile, LineNumberTable

# ===========================
# ✅ AndroidX Lifecycle (for observers)
# ===========================
-keep class androidx.lifecycle.DefaultLifecycleObserver { *; }
-keep class androidx.lifecycle.LifecycleObserver { *; }

# ==========================
# ✅ Retrofit & OkHttp (if used)
# ==========================
# -dontwarn okhttp3.**
# -dontwarn retrofit2.**
# -keep class retrofit2.** { *; }
# -keep interface retrofit2.** { *; }

# ===========================
# ✅ ML, and common libs
# ===========================
-dontwarn org.apache.**
-dontwarn org.joda.time.**
-dontwarn org.ietf.jgss.**
-dontwarn org.shaded.apache.**

# ===========================
# ✅ Native method references (for JNI calls)
# ===========================
-keepclasseswithmembernames class * {
    native <methods>;
}

# ==========================
# ✅ General Safety
# ==========================
# Keep annotations & inner classes for frameworks that rely on reflection
-keepattributes *Annotation*, EnclosingMethod, InnerClasses

# ===========================
# ✅ Optional: Handle common serialization & reflection (ML libs)
# ===========================
-keep class com.fasterxml.jackson.** { *; }
-keep class org.json.** { *; }

# ===========================
# ✅ General clean-up
# ===========================
# Disable overly aggressive optimizations if unsure (optional safety net)
# -dontoptimize

# Safer than -ignorewarnings in production builds
# Instead, collect mappings to debug obfuscation if needed
# -printmapping mapping.txt

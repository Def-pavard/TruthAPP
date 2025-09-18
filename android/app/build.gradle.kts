plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    compileSdk = 35 // Version récente du SDK (ajustée pour 2025)
    defaultConfig {
        applicationId = "com.thruthai.truthapp"
        minSdk = 21
        targetSdk = 35
        versionCode = 1
        versionName = "1.0.0"
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        // Configuration pour les notifications locales
        manifestPlaceholders["appName"] = "Truth AI"
        // Ajout de métadonnées pour les permissions (ex. image_picker)
        multiDexEnabled = true // Nécessaire si beaucoup de dépendances
    }
    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            // Optimisation pour les notifications
            resValue("string", "app_name", "Truth AI")
        }
        debug {
            applicationIdSuffix = ".debug"
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }
    // Configuration pour les assets (images, GIFs, shaders)
    sourceSets {
        getByName("main") {
            res.srcDirs("src/main/res")
            assets.srcDirs("src/main/assets", "assets")
        }
    }
    // Configuration pour les notifications locales
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {
    implementation("androidx.appcompat:appcompat:1.7.0")
    implementation("com.google.android.material:material:1.12.0")
    implementation("androidx.multidex:multidex:2.0.1") // Support MultiDex
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test.ext:junit:1.1.5")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.5.1")

    // Dépendances natives optionnelles pour les packages Flutter
    implementation("androidx.core:core:1.13.0") // Support pour permissions
    implementation("com.google.firebase:firebase-messaging:24.0.0") // Si notifications Firebase
}

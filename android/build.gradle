// build.gradle.kts (niveau projet)
buildscript {
    repositories {
        google() // Dépôt pour les artefacts Android
        mavenCentral() // Dépôt Maven central
    }
    dependencies {
        classpath("com.android.tools.build:gradle:9.0.0") // Version récente compatible avec 2025
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

tasks.register("clean", Delete::class) {
    delete(buildDir)
}

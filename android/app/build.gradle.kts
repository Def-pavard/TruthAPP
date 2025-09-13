buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.7.0'  // Dernière version stable d'AGP
        classpath 'org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.24'  // Dernière version stable de Kotlin
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

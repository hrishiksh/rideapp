package io.flutter.plugins;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;
import com.baseflow.geolocator.GeolocatorPlugin;
import com.tekartik.sqflite.SqflitePlugin;

public class CustomApplication extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {
    // @Override
    // public void onCreate() {
    //     super.onCreate();
    //     WorkmanagerPlugin.setPluginRegistrantCallback(this);

    // }
    @Override
    public void registerWith(PluginRegistry registry) {
        GeolocatorPlugin.registerWith(registry.registrarFor("com.baseflow.geolocator.GeolocatorPlugin"));
        SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
    }
}
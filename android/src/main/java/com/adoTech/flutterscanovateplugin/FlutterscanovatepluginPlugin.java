package com.adoTech.flutterscanovateplugin;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;

import androidx.annotation.NonNull;

import com.google.gson.Gson;

import java.util.HashMap;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import mabel_tech.com.scanovate_demo.ScanovateHandler;
import mabel_tech.com.scanovate_demo.ScanovateSdk;
import mabel_tech.com.scanovate_demo.model.CloseResponse;

/** FlutterscanovatepluginPlugin */
public class FlutterscanovatepluginPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  Context context;
  Activity activity;
  String documentType;
  int productId;
  Boolean show_LevelerUI;
  String projectName;
  String apiKey;
  String urlSdk;
  String numberIdentification;
  Boolean verification;
  String userName;
  String password;



  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.context = flutterPluginBinding.getApplicationContext();
    channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutterscanovateplugin");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding activityPluginBinding) {
    this.activity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {

  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutterscanovateplugin");
    channel.setMethodCallHandler(new FlutterscanovatepluginPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("callScanovate")){
        HashMap ls_data;
        ls_data = call.argument("data");
        documentType = (String) ls_data.get("documentType");
        productId = (int)ls_data.get("productId");
        //show_LevelerUI = (Boolean)ls_data.get("show_LevelerUI");
        projectName = (String) ls_data.get("projectName");
        apiKey = (String) ls_data.get("apiKey");
        urlSdk = (String) ls_data.get("urlSdk");
        numberIdentification = (String)ls_data.get("documentNumber");
        verification = (Boolean)ls_data.get("verification");
        userName = (String) ls_data.get("userName");
        password = (String) ls_data.get("password");

        capture(result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  public void capture(@NonNull final Result result) {
    ScanovateSdk.start(this.activity,
            documentType,
            productId,
            //ñ``show_LevelerUI,
            projectName,
            apiKey,
            urlSdk,
            numberIdentification,
            verification,
            userName,
            password,
            new ScanovateHandler() {
              @Override
              public void onSuccess(CloseResponse response, int code, String uuidDevice) {
                String jsonResponse;
                Gson gson = new Gson();
                jsonResponse = gson.toJson(response);

                result.success(jsonResponse);
               }

              @Override
              public void onFailure(CloseResponse closeResponse) {
                  String jsonResponse;
                  Gson gson = new Gson();
                  jsonResponse = gson.toJson(closeResponse);
                result.success(jsonResponse);
              }


            });
  }
}

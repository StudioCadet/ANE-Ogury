ANE-Ogury
===============

Air native extension for Ogury Presage, on Android (ARM and x86)

Documentation
----------

The documentation is available under */doc/index.html*

Install
-------

You need to add this to your application XML descriptor :

```xml
<android>
    <manifestAdditions><![CDATA[
        <manifest android:installLocation="auto">
            
            ...
			
			<!-- # OGURY PRESAGE # -->
			
			<!-- Default internet and boot permissions -->
			<uses-permission android:name="android.permission.INTERNET" />
			<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
			<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
			<uses-permission android:name="android.permission.READ_PHONE_STATE" />
			<uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
			<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />

			<!-- Tracking permissions -->
			<uses-permission android:name="android.permission.GET_TASKS" />
			<uses-permission android:name="android.permission.GET_TOP_ACTIVITY_INFO" />
			<uses-permission android:name="android.permission.READ_HISTORY_BOOKMARKS" />
			<uses-permission android:name="android.permission.WRITE_HISTORY_BOOKMARKS" />
			<uses-permission android:name="com.android.browser.permission.READ_HISTORY_BOOKMARKS" />
			<uses-permission android:name="com.android.browser.permission.WRITE_HISTORY_BOOKMARKS" />
			
			<!-- Shortcut permissions -->
			<uses-permission android:name="android.permission.INSTALL_SHORTCUT" />
			<uses-permission android:name="android.permission.UNINSTALL_SHORTCUT" />
			<uses-permission android:name="com.android.launcher.permission.INSTALL_SHORTCUT" />
			<uses-permission android:name="com.android.launcher.permission.UNINSTALL_SHORTCUT" />
            
			<!-- # END OF OGURY PRESAGE # -->
			
            ...

            <application>

                ...
                
				<!-- PRESAGE SDK -->
				<meta-data android:name="presage_key" android:value="YOUR_APP_KEY"/>
				<service android:name="io.presage.services.PresageServiceImp"/>
				<activity android:name="io.presage.activities.WebviewAdActivity" android:launchMode="singleInstance" 
						  android:label="YOUR_APP_NAME"
						  android:theme="@style/Presage.Theme.Transparent">
					<intent-filter>
						<action android:name="io.presage.intent.action.LAUNCH_WEBVIEW" />
						<category android:name="android.intent.category.DEFAULT" />
					</intent-filter>
				</activity>
				<receiver android:name="io.presage.receivers.BootReceiver">
					<intent-filter>
						<action android:name="android.intent.action.BOOT_COMPLETED"/>
						<action android:name="io.presage.receivers.BootReceiver.RESTART_SERVICE"/>
					</intent-filter>
				</receiver>
                
            </application>

        </manifest>
    ]]></manifestAdditions>
</android>
```

Build
-----

An ANT build script is in the build folder if you want to recompile the ANE. You can separately rebuild each part (actionscript, android, ane, and doc) using the different targets.
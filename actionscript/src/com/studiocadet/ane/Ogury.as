package com.studiocadet.ane {
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.geom.Point;
	import flash.sampler.getLexicalScopes;
	import flash.system.Capabilities;
	
	/**
	 * A singleton to work with Ogury. Simply call <code>start()</code> once in your app to start Ogury presage.
	 * Only works on Android.
	 */
	public class Ogury {
		
		// CONSTANTS :
		private static const EXTENSION_ID:String = "com.studiocadet.Ogury";
		
		// PROPERTIES :
		/** The logging function you want to use. Defaults to trace. */
		public static var logger:Function = trace;
		/** The prefix appended to every log message. Defaults to "[Inneractive]". */
		public static var logPrefix:String = "[Ogury]";
		
		private static var _isSupported:Boolean;
		private static var _isSupportedInitialized:Boolean;
		/**
		 * Returns true if the extension is supported on the current platform.
		 */
		public static function isSupported():Boolean {
			if(!_isSupportedInitialized) {
				_isSupported = Capabilities.manufacturer.toLowerCase().indexOf("android") > -1;
				_isSupportedInitialized = true;
			}
			return _isSupported;
		}
		
		// METHODS :
		/**
		 * Starts Ogury if Ogury is available.
		 */
		public static function start():void {
			if(!isSupported()) {
				log("Ogury is not supported on this platform.");
				return;
			}
			
			// Initialize the native part :
			log("Starting Ogury ...");
			const context:ExtensionContext = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
			context.call("ogury_Start");
			log("Ogury started.");
		}
		
		
		/////////////
		// LOGGING //
		/////////////
		
		/**
		 * Outputs the given message(s) using the provided logger function, or using trace.
		 */
		private static function log(message:String, ... additionnalMessages):void {
			if(logger == null) return;
			
			if(!additionnalMessages)
				additionnalMessages = [];
			
			logger((logPrefix && logPrefix.length > 0 ? logPrefix + " " : "") + message + " " + additionnalMessages.join(" "));
		}
	}
}
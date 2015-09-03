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
		
		// EVENTS :
		private static const AD_SERVED:String = "OguryEvent.AdServed";
		private static const NO_AD:String = "OguryEvent.NoAd";
		private static const AD_CLOSED:String = "OguryEvent.AdClosed";
		
		// CONSTANTS :
		private static const EXTENSION_ID:String = "com.studiocadet.Ogury";
		
		// PROPERTIES :
		/** The logging function you want to use. Defaults to trace. */
		public static var logger:Function = trace;
		/** The prefix appended to every log message. Defaults to "[Ogury]". */
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
		
		private static var _isInitialized:Boolean;
		/** Whether the extension has already been initialized. */
		public static function get isInitialized():Boolean { return _isInitialized; }
		
		/** The extension context instance used. */
		private static var context:ExtensionContext;
		
		
		// METHODS :
		/**
		 * Starts Ogury if Ogury is available.
		 */
		public static function start():void {
			
			// Init only once :
			if(_isInitialized) {
				log("Ogury is already initialized. Aborting.");
				return;
			}
			_isInitialized = true;
			
			// OS not supported :
			if(!isSupported()) {
				log("Ogury is not supported on this platform.");
				return;
			}
			
			// Initialize the native part :
			log("Starting Ogury ...");
			context = ExtensionContext.createExtensionContext(EXTENSION_ID, null);
			context.call("ogury_Start");
			log("Ogury started.");
		}
		
		/**
		 * Tries to serve an interstitial ad through Ogury.
		 * 
		 * @param onAdShown 	function():void
		 * @param onFailure		function():void
		 * @param onAdClosed	function():void
		 */
		public static function serveAd(onAdShown:Function, onFailure:Function, onAdClosed:Function = null):void {
			if(!_isInitialized) {
				log("Ogury is not initialized! Aborting.");
				return;
			}
			
			if(!isSupported()) {
				log("Ogury is not supported on this platform. Aborting.");
				return;
			}
			
			log("Trying to serve an interstitial ad ...");
			context.addEventListener(StatusEvent.STATUS, onStatusEvent);
			context.call("ogury_ServeAd");
			
			function onStatusEvent(ev:StatusEvent):void {
				context.removeEventListener(StatusEvent.STATUS, onStatusEvent);
				if(ev.code == AD_SERVED) {
					log("Ad served succesfully.");
					if(onAdShown != null)
						onAdShown();
				}
				else if(ev.code == NO_AD) {
					log("No ad to be served.");
					if(onFailure != null)
						onFailure();
				}
				else if(ev.code == AD_CLOSED) {
					log("Ad closed.");
					if(onAdClosed != null)
						onAdClosed();
				}
				else 
					log("Unknown event : [" + ev.code + "] " + ev.level);
			}
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
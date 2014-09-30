package com.studiocadet.functions;

import io.presage.Presage;
import io.presage.utils.IADHanlder;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.studiocadet.OguryExtension;

/**
 * Tries to display an interstitial with Ogury. Dispatches events to inform 
 */
public class OguryServeAdFunction implements FREFunction {
	
	// EVENTS :
	private static final String AD_SERVED = "OguryEvent.AdServed";
	private static final String NO_AD = "OguryEvent.NoAd";
	

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		
		final FREContext extensionContext = context;
		
		OguryExtension.log("Trying to serve an interstitial ad through Ogury ...");
		Presage.getInstance().adToServe("interstitial", new IADHanlder() {
			
			@Override
			public void onAdNotFound() {
				OguryExtension.log("No ad to serve.");
				extensionContext.dispatchStatusEventAsync(NO_AD, "");
			}
			
			@Override
			public void onAdFound() {
				OguryExtension.log("Ad served successfully");
				extensionContext.dispatchStatusEventAsync(AD_SERVED, "");
			}
		});
		
		return null;
	}

}

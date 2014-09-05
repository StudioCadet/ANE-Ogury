package com.studiocadet.functions;

import io.presage.Presage;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.studiocadet.OguryExtension;

public class OguryStartFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		
		OguryExtension.log("Starting Ogury ...");
		Presage ogury = Presage.getInstance();
		ogury.setContext(context.getActivity().getBaseContext());
		ogury.start();
		OguryExtension.log("Ogury started ("
						+ "version : " + Presage.VERSION + " ; "
						+ "build : " + Presage.BUILD + " ; "
						+ "Key : " + ogury.getKey() + " ; "
						+ "Env : "  + ogury.getEnv() + ").");
		
//		ogury.adToServe("interstitial", new IADHanlder() {
//			@Override public void onAdNotFound() {
//				OguryExtension.log("Ogury interstitial ad not found.");
//			}
//			@Override public void onAdFound() {
//				OguryExtension.log("Ogury interstitial ad found.");
//			}
//		});
		
		return null;
	}

}

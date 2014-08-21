package com.studiocadet;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.studiocadet.functions.OguryStartFunction;

public class OguryExtensionContext extends FREContext {
	
	// CONSTRUCTOR :
	/**
	 * Initializes and starts Ogury Presage.
	 */
	public OguryExtensionContext() {
		super();
	}
	
	
	/////////////////
	// FRE METHODS //
	/////////////////


	/**
	 * Disposes the extension context instance.
	 */
	@Override
	public void dispose() {
		OguryExtension.log("Context disposed.");
	}

	/**
	 * Declares the functions mappings.
	 */
	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
		
		functions.put("ogury_Start", new OguryStartFunction());
		
		OguryExtension.log(functions.size() + " extension functions declared.");
		
		return functions;
	}
}

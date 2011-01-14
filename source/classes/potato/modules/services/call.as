package potato.modules.services
{
	import potato.modules.services.ServiceManager;
	
	/**
	 * Shortcut for creating new service calls.
	 * 
	 * @param serviceID String The service id.
	 * @param callParameters Object Service parameters.
	 * @param callConfiguration Object Configuration object. Accepts the following shortcuts: onComplete, onProgress, onError.
	 */
	public function call(serviceID:String, callParameters:Object = null, callConfiguration:Object = null):void
	{
		ServiceManager.instance.call(serviceID, callParameters, callConfiguration);
	}
	
}

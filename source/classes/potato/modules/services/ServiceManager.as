package potato.modules.services
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import potato.modules.services.ServiceEvent;
	import flash.events.ProgressEvent;
	import br.com.stimuli.string.printf;
	
	/**
	 * Application service manager.
	 * 
	 * @langversion ActionScript 3
	 * @playerversion Flash 10.0.0
	 * 
	 * @author Fernando França
	 * @since  28.10.2010
	 */
	public class ServiceManager extends EventDispatcher
	{
		private var _registeredServices:Dictionary;
		private var _registeredParsers:Dictionary;
		
		public function ServiceManager(singleton:SingletonEnforcer)
		{
			_registeredServices = new Dictionary();
			_registeredParsers = new Dictionary();
		}
		
		public function registerServicesByConfig(parameters:Object):void
		{
			for each(var serviceConfig:Dictionary in parameters.services)
			{
				var serviceID:String = serviceConfig.id;
				var serviceURL:String = printf(serviceConfig.url, {servicePath: parameters.servicePath});
				var serviceParser:IResponseParser = getParserByID(serviceConfig.serialize);
				//var serviceParser:IResponseParser = getParserByID(serviceConfig.serialize);
				var serviceMethod:String = serviceConfig.method || "post";
				ServiceManager.instance.registerService(serviceID, new Service(serviceURL, serviceParser, null, serviceMethod));
				//trace(serviceURL, serviceID, serviceParser);
			}
		}
		
		public function registerParser(parser:IResponseParser):void
		{
			_registeredParsers[parser.id] = parser;
		}
		
		public function getParserByID(id:String):IResponseParser
		{
			if(_registeredParsers.hasOwnProperty(id))
				return _registeredParsers[id];
			else
				return null;
		}
		
		public function registerService(serviceName:String, service:Service):void
		{
			_registeredServices[serviceName] = service;
		}
		
		public function getServiceByName(serviceName:String):Service
		{
			return _registeredServices[serviceName];
		}
		
		public function call(serviceName:String, callParameters:Object = null, callConfiguration:Object = null):void
		{
			var serviceCall:ServiceCall = new ServiceCall(getServiceByName(serviceName), callParameters);
			
			// Handy configuration of listeners
			if(callConfiguration != null)
			{
				if(callConfiguration.hasOwnProperty("onComplete")) 
					serviceCall.addEventListener(ServiceEvent.CALL_COMPLETE, callConfiguration.onComplete, false, 0, true);
					
				if(callConfiguration.hasOwnProperty("onError"))
					serviceCall.addEventListener(ServiceEvent.CALL_ERROR, callConfiguration.onError, false, 0, true);
				
				if(callConfiguration.hasOwnProperty("onProgress"))
					serviceCall.addEventListener(ProgressEvent.PROGRESS, callConfiguration.onProgress, false, 0, true);
			}
			serviceCall.start();
		}
		
		private static var __instance:ServiceManager;
		
		public static function get instance():ServiceManager
		{
			if(!__instance)
				__instance = new ServiceManager(new SingletonEnforcer());
			return __instance;
		}
	}

}

/**
 * Enforces the Singleton design pattern.
 */
internal class SingletonEnforcer{}
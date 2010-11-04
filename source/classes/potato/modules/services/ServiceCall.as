package potato.modules.services
{
	import flash.net.URLLoader;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import br.com.stimuli.string.printf;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	/**
	 * Service call implementation. Any given service can have an unlimited number of calls.
	 * 
	 * @langversion ActionScript 3
	 * @playerversion Flash 9.0.0
	 * 
	 * @author Fernando França
	 * @since  28.10.2010
	 */
	public class ServiceCall extends EventDispatcher
	{
		protected var _service:Service;
		protected var _parameters:Object;
		protected var _content:Object;
		protected var _rawContent:String;
		protected var _urlLoader:URLLoader;
		
		public function ServiceCall(service:Service, parameters:Object = null, urlParameters:Object = null)
		{
			_service = service;
			_parameters = parameters;
		}
		
		public function start():void
		{
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, onComplete);
         _urlLoader.addEventListener(Event.OPEN, onOpen);
         _urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
         _urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
         _urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHttpStatus);
         _urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			var urlRequest:URLRequest = new URLRequest(printf(_service.url, _parameters));
			
			if(_parameters)
			{
				var urlVariables:URLVariables = new URLVariables();
				for(var key:String in _parameters)
				{
					if(_service.encoder)
						urlVariables[key] = _service.encoder.encode(_parameters[key]);
					else
						urlVariables[key] = _parameters[key];
				}
				urlRequest.data = urlVariables;
			}
			//trace(urlRequest.url + "?" + urlVariables.toString())
			urlRequest.method = _service.requestMethod;
			
			try {
				_urlLoader.load(urlRequest);
			}
			catch (error:Error) {
         	trace("[ServiceCall] Unable to load requested document.");
				dispatchEvent(new ServiceEvent(ServiceEvent.CALL_ERROR));
			}
		}
		
		protected function onComplete(e:Event):void
		{
			_rawContent = URLLoader(e.target).data;
			_content = _service.parser.parse(_rawContent);
			var serviceEvent:ServiceEvent = new ServiceEvent(ServiceEvent.CALL_COMPLETE);
			serviceEvent.rawContent = _rawContent;
			serviceEvent.content = _content;
			dispatchEvent(serviceEvent);
		}

		protected function onOpen(e:Event):void {
		   //trace("[ServiceCall] Open");
		}

		protected function onProgress(e:ProgressEvent):void {
			dispatchEvent(e);
		}

		protected function onSecurityError(e:SecurityErrorEvent):void {
		   trace("[ServiceCall] Security Error", e);
			dispatchEvent(new ServiceEvent(ServiceEvent.CALL_ERROR));
		}

		protected function onHttpStatus(e:HTTPStatusEvent):void {
		   //trace("[ServiceCall] HTTP Status:", e);
		}

		protected function onIOError(e:IOErrorEvent):void {
			trace("[ServiceCall] IO Error", e);
			dispatchEvent(new ServiceEvent(ServiceEvent.CALL_ERROR));
		}
		
	}

}
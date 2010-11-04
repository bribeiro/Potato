package potato.modules.services
{
	/**
	 * Describes an application service. This class is a simple data holder.
	 * 
	 * @langversion ActionScript 3
	 * @playerversion Flash 10.0.0
	 * 
	 * @author Fernando França
	 * @since  28.10.2010
	 */
	public class Service
	{
		protected var _url:String;
		protected var _parser:IResponseParser;
		protected var _encoder:ICallEncoder;
		protected var _timeout:int;
		protected var _retries:int;
		protected var _requestMethod:String;
		
		public function Service(url:String, parser:IResponseParser, encoder:ICallEncoder, requestMethod:String, timeout:int = 10000, retries:int = 3)
		{
			_url = url;
			_parser = parser;
			_encoder = encoder;
			_requestMethod = requestMethod;
			_timeout = timeout;
			_retries = retries;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get parser():IResponseParser
		{
			return _parser;
		}
		
		public function get encoder():ICallEncoder
		{
			return _encoder;
		}
		
		public function get requestMethod():String
		{
			return _requestMethod;
		}
		
		public function get timeout():int
		{
			return _timeout;
		}
		
		public function get retries():int
		{
			return _retries;
		}
	}

}


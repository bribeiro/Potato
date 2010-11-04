package potato.modules.services
{
	import flash.events.Event;
	
	/**
	 * Service event implementation. Simplified service error handling is available through this class.
	 * 
	 * @langversion ActionScript 3
	 * @playerversion Flash 10.0.0
	 * 
	 * @author Fernando França
	 * @since  28.10.2010
	 */
	public class ServiceEvent extends Event
	{
		public static const CALL_START:String    = "call_start";
		public static const CALL_COMPLETE:String = "call_complete";
		public static const CALL_ERROR:String    = "call_error";
		public static const CALL_RETRY:String    = "call_retry";
		
		protected var _content:Object = null;
		protected var _rawContent:Object = null;
		
		public function ServiceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function get content():Object
		{
			return _content;
		}
		
		public function set content(value:Object):void
		{
			_content = value;
		}
		
		public function get rawContent():Object
		{
			return _rawContent;
		}
		
		public function set rawContent(value:Object):void
		{
			_rawContent = value;
		}
		
	}
}

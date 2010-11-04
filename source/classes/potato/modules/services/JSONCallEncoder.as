package potato.modules.services
{
	import com.adobe.serialization.json.JSONEncoder;
	import potato.modules.services.ICallEncoder;

	public class JSONCallEncoder implements ICallEncoder
	{
		public function get id():String
		{
			return "json";
		}
		
		public function encode(value:*):String
		{
			try
			{
				var jsonEncoder:JSONEncoder = new JSONEncoder(value);
				var content:String = jsonEncoder.getString();
				return content;
			}
			catch (e:Error)
			{
				trace("JSONCallEncoder::encode() error", e.message);
				return null;
			}
		}
	}
}
package potato.modules.dependencies
{
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.utils.ByteArray;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.
  
	import potato.core.IDisposable;
	import potato.core.config.IConfig;
  
	public interface IDependencies extends IEventDispatcher, IDisposable
	{
		
		function inject(config:IConfig):void;
		
		function addItem(url:*, props:Object = null):void;
		
		/**
		 * Start loading the dependencies.
		 * Dispatches <code>Event.COMPLETE</code> when done.
		 */
		function load() : void;
		
		//TODO implement a nice interface here
		
		function getBitmap(key:String):Bitmap;
		function getBitmapData(key:String):BitmapData;
    function getByteArray(key:String):ByteArray;
		function getContent(key:String):*;
		function getDisplayObject(key:String):DisplayObject;
    function getLoader(key:String):Loader;
		function getSound(key:String):Sound;
		function getString(key:String):String;
    function getXML(key:String):XML;
	}

}


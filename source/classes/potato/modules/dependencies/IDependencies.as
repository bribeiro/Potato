package potato.modules.dependencies
{
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	
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
		function load():void;
		
		//TODO implement a nice interface here
		//getContent():*
		function getData(key:String):*;
		//getXML
		//getString
		//getSound
	  function getBitmap(key:String):Bitmap;
		function getBitmapData(key:String):BitmapData;
    //getDisplayObjectLoader
    //getMovieClip
    //getByteArray    
    //function getByteArray(key:String):ByteArray;
    //function getMovieClip(key:String):MovieClip;
    //function getNetStream(key:String):NetStream;
    function getXML(key:String):XML;
	}

}


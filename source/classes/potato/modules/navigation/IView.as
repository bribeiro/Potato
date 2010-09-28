package potato.modules.navigation
{
	import potato.core.IDisposable;
	import potato.core.IResizable;
	import potato.core.IVisible;
	import potato.core.config.IConfig;
	
	/**
	 * Defines View's responsibilities.
	 * 
	 * @langversion ActionScript 3
	 * @playerversion Flash 10.0.0
	 * 
	 * @author Fernando França
	 * @since  06.08.2010
	 */
	public interface IView extends IDisposable, IVisible, IResizable
	{
		// The unique identifier for the view
		function get id():String;
		
		// Screen zIndex
		function get zIndex():int;
		
		// Generic view configuration
		function get config():IConfig;
		
		// Initialization
		function init():void;
		function get initialized():Boolean;
		
		// Navigation
		function msg(view:String):ViewMessenger;
        function addView(view:String):void;
		function removeView(view:String):void;
		function changeView(view:String):void;
		function loaderFor(view:String):ViewLoader;
	}

}

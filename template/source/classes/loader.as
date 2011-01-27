package
{	
	import potato.modules.navigation.presets.YAMLSiteView;
	import potato.modules.navigation.ViewLoader;
	import flash.events.Event;
	public class {project_name}_loader extends YAMLSiteView
	{

		override public function init():void
		{
			var vl:ViewLoader = loaderFor("main");
			vl.addEventListener(Event.COMPLETE, onMainLoadComplete, false, 0, true);
			vl.start();
		}
		
		public function onMainLoadComplete(e:Event):void
		{
			e.target.removeEventListener(Event.COMPLETE, onMainLoadComplete);
			changeView("main");
		}

	}
}
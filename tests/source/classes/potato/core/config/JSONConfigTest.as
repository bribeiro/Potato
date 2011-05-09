package potato.core.config
{	
  import potato.core.config.JSONConfig;
	import potato.core.config.Config;
	import flash.events.*;
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class JSONConfigTest 
	{
    private const JSON_PATH:String = "data/config.json";

    [Test(async)]
    public function boolParsing():void
    {
      var asyncHandler:Function = Async.asyncHandler(this, function(e:Event, o:*):void{
        trace(config._config);
        config.removeEventListener(Event.INIT, asyncHandler);
        Assert.assertEquals(config.getProperty("bool"), true);
      }, 5000, null, handleTimeout);

      var config:JSONConfig = new JSONConfig(JSON_PATH);
      config.addEventListener(Event.INIT, asyncHandler)
      config.init();
    }

    [Test(async)]
    public function stringParsing():void
    {
      var asyncHandler:Function = Async.asyncHandler(this, function(e:Event, o:*):void{
        config.removeEventListener(Event.INIT, asyncHandler);
        Assert.assertEquals(config.getProperty("str"), "my fançy and complex StRiNg!");
      }, 5000, null, handleTimeout);

      var config:JSONConfig = new JSONConfig(JSON_PATH);
      config.addEventListener(Event.INIT, asyncHandler)
      config.init();
    }

    [Test(async)]
    public function numberParsing():void
    {
      var asyncHandler:Function = Async.asyncHandler(this, function(e:Event, o:*):void{
        config.removeEventListener(Event.INIT, asyncHandler);
        Assert.assertEquals(config.getProperty("float"), 1.23456);
      }, 5000, null, handleTimeout);

      var config:JSONConfig = new JSONConfig(JSON_PATH);
      config.addEventListener(Event.INIT, asyncHandler)
      config.init();
    }
    
    [Test(async)]
    public function simpleObjectParsing():void
    {
      
var asyncHandler:Function = Async.asyncHandler(this, function(e:Event, o:*):void{
        config.removeEventListener(Event.INIT, asyncHandler);
        
        var result : Object = {
          code: 10938990398418903843,
          result:true,
          message:"my simple object"
        };
        
        for(var p : String in result)
          Assert.assertEquals(config.getProperty("object")[p], result[p]);
          
      }, 5000, null, handleTimeout);
      
      var config:JSONConfig = new JSONConfig(JSON_PATH);
      config.addEventListener(Event.INIT, asyncHandler)
      config.init();
    }
    
    [Test(async)]
    public function simpleArrayParsing():void
    {
       var asyncHandler:Function = Async.asyncHandler(this, function(e:Event, o:*):void{
       config.removeEventListener(Event.INIT, asyncHandler);

       var result : Array = [
         "one",
         2,
         "III",
         false,
         true,
         null,
         "áííóú ÁÉÍÓÚ çÇ"
       ];
       
       var i : int;

       for each(var index : * in result)
         Assert.assertEquals(config.getProperty("array")[i], result[i++]);

     }, 5000, null, handleTimeout);

     var config:JSONConfig = new JSONConfig(JSON_PATH);
     config.addEventListener(Event.INIT, asyncHandler)
     config.init();
    }
    
    [Test(async)]
    public function complexJsonParsing():void
    {
      var asyncHandler:Function = Async.asyncHandler(this, function(e:Event, o:*):void{
        config.removeEventListener(Event.INIT, asyncHandler);

        var complexObject : Object =
        {
          name:"Is my name",
          gender:"M",
          birth:1981,
          cost:5983.27,
          count:908098409238403472,
          var_underscored : "a var undersocre",
          array:
          [
            "one",
            2,
            "III",
            false,
            true,
            null,
            "éíóúâêîôûàèìòùäëïöüãõç ÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÇ",
            {
              code: 10933208409238938,
              result:false,
              message:"hash item 2 in da house",
              array:["a", 2, {one:1, two:"two", end:true, latin:"éíóúâêîôûàèìòùäëïöüãõç ÉÍÓÚÂÊÎÔÛÀÈÌÒÙÄËÏÖÜÃÕÇ"}]
            }
          ],
          hash:{
            item1:
            {
              code: 10938990398418903843,
              result:true,
              message:"my simple object"
            },
            item2:
            {
              code: 10933208409238938,
              result:false,
              message:"hash item 2 in da house"
            },
            item3:
            {
              code: 10933208409238938,
              result:false,
              message:"hash item 2 in da house"
            }
          }
        };

        var i : int;

        for(var prop : * in complexObject)
        {
          switch( prop )
          {
            default:
              // primitive typing
              Assert.assertEquals( typeof config.getProperty("complexObject")[ prop ], typeof complexObject[ prop ]);
              
              // equality 
              Assert.assertEquals( config.getProperty("complexObject")[ prop ], complexObject[ prop ]);
            break;

            case "array":
              i = 0;
              Assert.assertEquals(config.getProperty("complexObject").array is Array, true );
              for each( var index : * in complexObject.array )
                if( typeof( complexObject.array[ i ] ) == "object" )
                  for( var p : String in complexObject.array[ i ] )
                    Assert.assertEquals(config.getProperty("complexObject").array[ i ][ p ], complexObject.array[ i++ ][ p ]);
                else
                {
                  Assert.assertEquals(config.getProperty("complexObject").array[ i ], complexObject.array[ i ]  );
                }
            break;

            case "hash":
              Assert.assertEquals( typeof config.getProperty("complexObject").hash, "object"  )
              for( var p1 : String in complexObject.hash )
                for( var p2 : String in complexObject.hash[ p1 ] )
                  Assert.assertEquals( config.getProperty("complexObject").hash[ p1 ][ p2 ], complexObject.hash[ p1 ][ p2 ]);
            break;
          }
        }
        
      }, 5000, null, handleTimeout);

      var config:JSONConfig = new JSONConfig(JSON_PATH);
      config.addEventListener(Event.INIT, asyncHandler)
      config.init();
    }


    //Failed
    public function handleTimeout(e:Event):void
    {
      Assert.fail("timeout");
    }
	}
}

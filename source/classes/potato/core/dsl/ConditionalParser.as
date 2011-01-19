package potato.core.dsl
{

/**
 * Basic Conditional Parser. (not implemented yet)
 * 
 * <p><b>Conditional operators:</b>
 * <code>	!= &gt;= &gt; == &lt;= &lt; ~=</code>
 * </p>
 * 
 * <p>
 * <b>Variable types:</b>
 * <code>Number, String, null, RegEx, Object</code>
 * </p>
 * 
 * <p>
 * <b>EXAMPLE:</b>
 * 
 * <listing>
 * {
 *  'age': 35,
 *  'site': {
 *      'if': {
 *          "age >= 30": 'http://age.com',
 *          "age >= 18": 'http://anurl.com',
 *  		   "otherParam == 'stringValue'": "http://anotherurl.com",
 *          "else": "http://defaulturl.com"
 *      }
 *  }
 * }</listing>
 * </p>
 */

public class ConditionalParser
{

	public function ConditionalParser()
	{
	}
	
	public function match(condition:String):Boolean
	{
		//TODO implement conditional parser
		return false;
	}
	
}

}


package com.netoleal.core
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	public final class Assets
	{
		
		public static const ASSETFOLDER_ROOT:String = "root";
		public static const ASSETFOLDER_DATA:String = "data";
		
		private static var _instance:Assets;
		
		private var instanceDict:Dictionary;
		private const FOLDER:String = "fldr_";
		
		function Assets( enforcer:SingletonEnforcer ):void {
			this.instanceDict = new Dictionary;
		}
		
		/**
		 * Add an item to assets dictionary
		 * @param key
		 * @param value
		 * @param folder
		 * 
		 */		
		public function addItem( key:*, value:*, folder:String = "" ):void {
			if( folder != "" ){
				
				if( this.instanceDict[ FOLDER + folder ] == undefined ) this.instanceDict[ FOLDER + folder ] = new Dictionary( );
				this.instanceDict[ FOLDER + folder ][ key ] = value;
				
			} else this.instanceDict[ key ] = value;
		}
		
		/**
		 * Return an item by key
		 * @param key
		 * @return 
		 * 
		 */		
		public function getItem( key:*, folder:String = "" ):* {
			
			if( folder != "" ) return this.instanceDict[ FOLDER + folder ][ key ];
			else return this.instanceDict[ key ];
			
		}
		
		/**
		 * Remove item
		 * @param key
		 * @return 
		 * 
		 */
		public function removeItem( key:* ):void{
			delete this.instanceDict[ key ];
		}
		
		/**
		 * Get Assets instance. Singleton
		 * @return 
		 * 
		 */		
		public static function getInstance( ):Assets {
			if( _instance == null ) _instance = new Assets( new SingletonEnforcer( ) );
			return _instance;
		}
		
		public function createObject(theClassName : String) : *{
            var theClass : Class = getDefinitionByName(theClassName) as Class;
            return new theClass();
            
        }
        
        public function getClass(theClassName : String) : Class{
            var theClass : Class = getDefinitionByName(theClassName) as Class;
            return theClass;
        }
        
	}
	
}

/**
* Internal class for Singleton functionality
*/
internal class SingletonEnforcer { }
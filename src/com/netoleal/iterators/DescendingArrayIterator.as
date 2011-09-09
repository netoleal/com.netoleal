package com.netoleal.iterators {
	
	import com.netoleal.interfaces.IIterator;
	
	public class DescendingArrayIterator implements IIterator{
		
		private var _array:Array;
		
		private var _index:Number;
		private var _firstIndex:Number = 0;
		private var _lastIndex:Number;
		
		function DescendingArrayIterator( targetArray:Array ) {
			
			this._firstIndex = targetArray.length-1;
			_index = _firstIndex;
			_array = targetArray;
			
		}
		
		/**
		* Return first element of array and reset INDEX
		*/
		public function first( ):* {
			_index = this._firstIndex;
			return current( );
		}
		
		/**
		* Return the last element of array and move INDEX to end
		*/
		public function last( ):* {
			_index = 0;
			return current( );
		}
		
		/**
		* Return current element
		* 
		*/
		public function current( ):* {
			return this._array[ this._index ];
		}
		
		/**
		* Return current index
		* 
		* @return
		*/
		public function index( ):Number {
			return this._firstIndex - this._index - 1;
		}
		
		/**
		* Return true if exist a next elemen
		* 
		* @return
		*/
		public function hasNext( ):Boolean {
			return ( _index > -1 );
		}
		
		/**
		* Return the next element
		*/
		public function next( ):* {
			if( !hasNext( ) ) return undefined;
			
			return this._array[ this._index -- ];
		}
	}
}
package com.netoleal.loading
{
	
	import com.netoleal.loading.BatchPreloaderElement;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import com.netoleal.events.EventDispatcherExtended;
	import flash.utils.Dictionary;
	import com.netoleal.events.BatchPreloaderEvent;
	import flash.system.LoaderContext;

	public class BatchPreloader extends EventDispatcherExtended
	{
		
		private var targets:Array;
		private var targetsByDispatcher:Dictionary;
		private var bytesLoaded:Number;
		private var bytesTotal:Number;
		
		private var filesLoaded:uint;
		
		private var loading:Boolean = false;
		
		public function BatchPreloader()
		{
			
			super( this );
			removeAll( );
		}
		
		public function removeAll( ):void {
			targets = new Array( );
			targetsByDispatcher = new Dictionary( );
		}
		
		public function addChild( dispatcherObject:EventDispatcher, url:URLRequest, loaderObject:Object = null, context:LoaderContext = null ):void {
			
			removeChild( dispatcherObject );
			
			var child:BatchPreloaderElement = new BatchPreloaderElement( dispatcherObject, url, loaderObject, context );
			
			child.addEventListener( Event.COMPLETE, handlerEvent );
			child.addEventListener( ProgressEvent.PROGRESS, handlerEvent );
			child.addEventListener( IOErrorEvent.IO_ERROR, handlerEvent );
			child.addEventListener( Event.OPEN, handlerEvent );
			
			this.targets.push( child );
			this.targetsByDispatcher[ dispatcherObject ] = child;
			
		}
		
		private function handlerEvent( evt:Event ):void {
			
			switch( evt.type ){
				case Event.COMPLETE:
					
					filesLoaded++;
					
					if( filesLoaded == this.targets.length ){
						
						loading = false;
						this.dispatchEvent( new Event( Event.COMPLETE ) );
						
					}
					
				break;
				case ProgressEvent.PROGRESS:
					
					this.dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, this.getBytesLoaded( ), this.getBytesTotal( ) ) );
					
				break;
				case IOErrorEvent.IO_ERROR:
				
					if( !this.willTrigger( IOErrorEvent.IO_ERROR ) ){
						throw new Error( "Unhandled loading error: " + ( evt as IOErrorEvent ).text );
					}
					
					this.dispatchEvent( evt.clone( ) );
					
				break;
				case Event.OPEN:
				
					var newEvt:BatchPreloaderEvent = new BatchPreloaderEvent( BatchPreloaderEvent.OPEN );
					newEvt.currentLoader = newEvt.target;
					
					this.dispatchEvent( newEvt );
					
				break;
				
			}
			
		}
		
		public function getIsLoading( ):Boolean {
			
			return this.loading;
			
		}
		
		public function removeChild( dispatcherObject:EventDispatcher ):void {
			
			if( loading ) return;
			
			var n:uint = 0;
			var element:BatchPreloaderElement;
			
			while( element = this.targets[ n++ ] ){
				
				if( element == dispatcherObject ){
					
					element.clearListeners( );
					this.targets.splice( n - 1, 1 );
					this.targetsByDispatcher[ dispatcherObject ] = null;
					
					return;
					
				}
				
			}
			
		}
		
		public function getBatchPreloaderElementByDispatcher( dispatcherObject:EventDispatcher ):BatchPreloaderElement {
			
			return this.targetsByDispatcher[ dispatcherObject ];
			
		}
		
		public function load( ):void {
			
			if( loading ) return;
			loading = true;
			
			filesLoaded = 0;
			
			var n:uint = 0;
			var element:BatchPreloaderElement;
			var total:Number;
			
			while( element = this.targets[ n++ ] ){
				element.load( );
			}
			
		}
		
		public function getFilesLoaded( ):uint {
			return this.filesLoaded;
		}
		
		public function getFilesTotal( ):uint {
			return this.targets.length;
		}
		
		public function getBytesLoaded( ):Number {
			
			var n:uint = 0;
			var element:BatchPreloaderElement;
			var total:Number = 0;
			
			while( element = this.targets[ n++ ] ){
				
				total += element.getBytesLoaded( );
				
			}
			
			return total;
			
		}
		
		public function getBytesTotal( ):Number {
			
			var n:uint = 0;
			var element:BatchPreloaderElement;
			var total:Number = 0;
			
			while( element = this.targets[ n++ ] ){
				
				total += element.getBytesTotal( );
				
			}
			
			return total;
			
		}
		
	}
	
}
package com.netoleal.events
{
	import flash.events.Event;

	public class BatchPreloaderEvent extends Event
	{
		
		public static const OPEN:String = "open";
		
		public var currentLoader:Object;
		
		public function BatchPreloaderEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
	
}
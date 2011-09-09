package com.netoleal.events
{
	import flash.events.Event;

	public class NetStreamEvent extends Event
	{
		
		public static const COMPLETE:String = "complete";
		public static const META_DATA:String = "metaData";
		public static const BUFFER_EMPTY:String = "bufferEmpty";
		public static const BUFFER_FULL:String = "bufferFull";
		public static const STOP:String = "stop";
		public static const PAUSE:String = "pause";
		public static const RESUME:String = "resume";
		public static const START:String = "start";
		
		public function NetStreamEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
package com.netoleal.common
{
	import com.netoleal.timeline.TimelineDrivenMovieClip;
	import flash.events.MouseEvent;

	public class ButtonInOut extends TimelineDrivenMovieClip
	{
		public function ButtonInOut()
		{
			super();
			this.stop( );
			
			this.addEventListener( MouseEvent.ROLL_OVER, this.overHandler );
			this.addEventListener( MouseEvent.ROLL_OUT, this.outHandler );
			
			this.buttonMode = true;
			this.mouseChildren = false;
			
		}
		
		private function overHandler( evt:MouseEvent ):void {
			this.animateToEndAndStop( );
		}
		
		private function outHandler( evt:MouseEvent ):void {
			this.animateToBeginAndStop( );
		}
		
	}
}
package game.view
{
	import flash.events.Event;
	
	import game.ui.sweeps.SweepStakeViewUI;
	
	import morn.core.handlers.Handler;
	
	public class SweepStakeView extends SweepStakeViewUI
	{
		public static var COMMIT_TO_DRAW:String = "commit event to draw ";//提交抽奖指令
		public function SweepStakeView()
		{
			super();
			commitBtn.clickHandler = new Handler(onCommitHandler);
		}
		
		/**
		 * 抽奖提交按钮， 扣钱发奖 ，根据玩家等级 
		 * 
		 */
		private function onCommitHandler():void
		{
			dispatchEvent(new Event(COMMIT_TO_DRAW));
		}
	}
}
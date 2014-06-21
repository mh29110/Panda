package game.view
{
	import game.controllers.GameEventDispatcher;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.ui.MainMenuUI;
	
	import morn.core.handlers.Handler;
	
	public class MainMenu extends MainMenuUI
	{
		public function MainMenu()
		{
			super();
			start.clickHandler = new Handler(onStartHanlder);
		}
		
		private function onStartHanlder():void
		{
			GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.READY_INTO_GAME));
		}
	}
}
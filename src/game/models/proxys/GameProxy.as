package game.models.proxys
{
	import game.controllers.GameEventDispatcher;

	public class GameProxy
	{
		protected var dispatcher:GameEventDispatcher;
		public function GameProxy()
		{
			dispatcher = GameEventDispatcher.getInstance();
		}
	}
}
package game.controllers
{
	public class Controller
	{
		protected var dispatcher:GameEventDispatcher;
		public function Controller()
		{
			dispatcher = GameEventDispatcher.getInstance();
		}
	}
}
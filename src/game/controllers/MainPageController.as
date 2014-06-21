package game.controllers
{
	import flash.display.Sprite;
	
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.roles.UserDataProxy;
	import game.view.MainPage;
	import game.view.TopUserInfoView;
	
	import morn.core.components.Label;

	/**
	 * 主界面+ 关卡 +  主要的功能菜单栏 　（悬浮于顶部的UI_Bar不在此处，需要单独设定 ） 
	 * @author leejia
	 * 
	 */
	public class MainPageController extends Controller
	{
		public function MainPageController()
		{
			super();
			initListeners();
		}
		
		private function initListeners():void
		{
			dispatcher.addEventListener(GameEventName.READY_INTO_GAME,onMainUIView);
			dispatcher.addEventListener(GameEventName.EXP_GOLD_CHANGE,onExpGoldChangeHandler);
		}
		
		public var topView:TopUserInfoView;
		/**
		 * @param event
		 * 
		 */
		private function onExpGoldChangeHandler(event:EventWithData):void
		{
			topView.goldText.text = "" + UserDataProxy.getInstance().gold;
			topView.expText.text = "" + UserDataProxy.getInstance().exp;
			topView.levelText.text = "" + UserDataProxy.getInstance().level;
		}
		
		private function onMainUIView(event:EventWithData):void
		{
			popUpView();
			//coding
			topView = new TopUserInfoView();
			topView.x = Global.gameStage.width/2 - topView.width/2;
			topView.y = 0;
			App.log.addChild(topView);
		}
		
		private function popUpView():void
		{
			Global.gameStage.addChild(mainPage);
		}
		private static var _instance:MainPageController;
		private var _mainPage:MainPage;

		public static function getInstance():MainPageController
		{
			return _instance ||= new MainPageController();
		}
		public function get mainPage():MainPage
		{
			if(!_mainPage)
			{
				_mainPage = new MainPage();
			}
			return _mainPage;
		}
		
		public function set mainPage(value:MainPage):void
		{
			_mainPage = value;
		}
	}
}
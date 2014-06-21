package game.controllers
{
	import flash.events.Event;
	
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.roles.RoleBasicVo;
	import game.view.LoginView;
	
	import morn.core.handlers.Handler;

	/**
	 * 负责控制 登录逻辑，登录界面 ，填充用户数据
	 * @author leejia
	 * 
	 */
	public class LoginController extends Controller
	{
		private var _loginView:LoginView;
		public function LoginController()
		{
			
			initListeners();
		}
		
			
		/**
		 * 初始化 服务器及其他controller的事件侦听 
		 *  socket  &  controllers 
		 */
		private function initListeners():void
		{
			dispatcher.addEventListener(GameEventName.LOGIN_EVENT,onCommit);
		}		
		
		private function onCommit(event:EventWithData):void
		{
			popDown();
			_loginView.dispose();
		}
		
		
		private function popDown():void
		{
			Global.gameStage.removeChild(_loginView);
		}
		
		private static var _instance:LoginController;
		public static function getInstance():LoginController
		{
			return _instance ||= new LoginController();
		}
		
		/**
		 * 弹出登录界面 
		 * 
		 */
		public  function popUpView():void
		{
			if(Global.isSingleGame){//如果debug模式，则不需要登录和创建人物
				
				
				
				MainController.getInstance().popUpMainMenu();
				loginView.dispose();
			}else{
				Global.gameStage.addChild(loginView);
			}
		}

		public function get loginView():LoginView
		{
			if(!_loginView)
			{
				_loginView = new LoginView();
			}
			return _loginView;
		}
		
		private function initUIListeners():void
		{
			
		}
		
		public function set loginView(value:LoginView):void
		{
			_loginView = value;
		}

	}
}
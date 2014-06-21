
package game.controllers
{
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.view.RolePage;
	
	/**
	 * 人物属性+ 背包界面  控制器
	 * @author leejia
	 * 
	 */
	public class RolePageController extends Controller
	{
		public function RolePageController()
		{
			super();
			initListeners();
		}
		
		
		private function initListeners():void
		{
			dispatcher.addEventListener(GameEventName.ROLE_Page_SHOW,onRoleUIView);
			dispatcher.addEventListener(GameEventName.SORT_GOODS_SIT,onSortGoodsHanlder);
		}
		
		/**
		 * 玩家物品列表发生变化后回调 
		 * @param event
		 * 
		 */
		private function onSortGoodsHanlder(event:EventWithData):void
		{
			rolePage.refreshBagData();
		}		
		
		private function onRoleUIView(event:EventWithData):void
		{
			popUpView();
		}
		
		private function popUpView():void
		{
			rolePage.refreshBagData();
			rolePage.refreshEquipments();
			Global.gameStage.addChild(rolePage);
		}
		private static var _instance:RolePageController;
		private var _rolePage:RolePage;
		public static function getInstance():RolePageController
		{
			return _instance ||= new RolePageController();
		}
		public function get rolePage():RolePage
		{
			if(!_rolePage)
			{
				_rolePage = new RolePage();
			}
			return _rolePage;
		}
		
		public function set rolePage(value:RolePage):void
		{
			_rolePage = value;
		}
	}
}
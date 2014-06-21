package game.controllers
{
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.roles.Player;
	import game.models.roles.UserDataProxy;
	import game.view.SkillPage;

	public class SkillPageController extends Controller
	{
		public function SkillPageController()
		{
			super();
			initListeners();
		}
		
		private function initListeners():void
		{
			//当技能升级时
			GameEventDispatcher.getInstance().addEventListener(GameEventName.SKILL_UPGRADE,onSkillUpgradeHandler);
		}
		
		/**
		 * 技能升级事件 
		 * @param event
		 * 
		 */
		private function onSkillUpgradeHandler(event:EventWithData):void
		{
			//需要升级技能的英雄
			
			var player:Player = UserDataProxy.getInstance()["user_"+event.data.hero];
			var flag:Boolean = false;//是否升级成功 
			
			for (var i:int = 0; i < player.skillManager.skillBeidong.length; i++) 
			{
				if(player.skillManager.skillBeidong[i].sitId == event.data.id) {
					flag =  player.skillManager.skillUpgrade(player.skillManager.skillBeidong[i]);//升级指定技能
				}
			}
			
			// todo  此处扩展 等级不够，金币不够，已经是最大级等升级失败，
			
			onSkillChange(flag,event.data.hero);
		}
		
		/**
		 * 技能改变后 
		 * @param event
		 * 
		 */
		private function onSkillChange(isSuccess:Boolean,index:int):void
		{
			if(isSuccess){//如果升级成功
				skillPage.refreshData(index);
			}else {
				trace("显示升级失败，已经是最大级");
				skillPage.nextExplain.text += "level max";
				//  此处SkillPage line 38 + 42  ＝ 需要在skillpage中实现一个方法，进行错误信息显示
				//  如果需要在全局显示tips或者浮动提示框，三个地方使用相同的实现方式。
			}
		}
		
		public function onShowPage():void
		{
			skillPage.refreshData(1);
			Global.gameStage.addChild(skillPage);
			
		}
		private static var _instance:SkillPageController;
		private var _skillPage:SkillPage;
		public static function getInstance():SkillPageController
		{
			return _instance ||= new SkillPageController();
		}
		public function get skillPage():SkillPage
		{
			if(!_skillPage)
			{
				_skillPage = new SkillPage();
			}
			return _skillPage;
		}
		
		public function set skillPage(value:SkillPage):void
		{
			_skillPage = value;
		}
	}
}
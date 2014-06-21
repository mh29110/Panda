package game.events
{
	public class GameEventName
	{
		public static const LOGIN_EVENT:String = "login in";
		public static var READY_INTO_GAME:String = "start enter game";
		public static var LIVE_THING_DEAD:String = "player hp = 0";
		
		public static const ROLE_Page_SHOW:String = "role page show ";//显示rolepage  UI
		public static var ROLE_SKILL_PAGE:String = "show role skill page";
		public static var SKILL_UPGRADE:String = "skill upgrade event";
		public static var SKILL_DATA_CHANGE:String = " skill data change  ";//由技能升级引起
		public static var LEVEL_UPGRADE:String = "level upgrade"; //升级事件
		
		public static const SORT_GOODS_SIT:String = "sort goods sit number";//物品列表变化
		public static var GOODS_SALE:String = "sale the goods";
		public static var GOODS_USE_EVENT:String = "use the goods";
		public static var EXP_GOLD_CHANGE:String = "exp change  or gold change";
		public static var SHOW_SWEEPSTAKE_VIEW:String = "show the sweepstake view up";//显示抽奖界面
		public function GameEventName()
		{
		}
	}
}
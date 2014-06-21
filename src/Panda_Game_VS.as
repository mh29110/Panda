package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.registerClassAlias;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Dictionary;
	
	import game.controllers.BattleController;
	import game.controllers.GameEventDispatcher;
	import game.controllers.LoginController;
	import game.controllers.MainController;
	import game.controllers.MainPageController;
	import game.controllers.RolePageController;
	import game.controllers.SkillPageController;
	import game.controllers.SweepStakeController;
	import game.managers.EquipManager;
	import game.managers.GameDataConfigManager;
	import game.managers.NetworkManager;
	import game.models.goodsVo.GoodsBasic;
	import game.models.goodsVo.GoodsDynamic;
	import game.models.roles.Player;
	import game.models.roles.RoleBasicVo;
	import game.models.roles.RoleDynamicVo;
	import game.models.skills.SkillInfo;
	import game.models.skills.SkillManager;
	
	import morn.core.handlers.Handler;
	
	import utils.debug.Stats;
	
	/**
	 * 主程序
	 */
	[SWF(width="960",height="640",backgroundColor="#ffffff")]	
	public class Panda_Game_VS extends Sprite {
		
		[Embed(source="splash/bg.jpg")]
		private var SplashBg:Class;

		/**
		 * 预载入画面 
		 */
		private var bm:Bitmap;
		    
		
		public function Panda_Game_VS() {
			bm = new SplashBg();
			addChild(bm);
			
			
			registerClassAlias("Player", Player);
			registerClassAlias("RoleVo", RoleBasicVo);
			registerClassAlias("GoodsDynamic", GoodsDynamic);
			registerClassAlias("SkillInfo", SkillInfo);
			registerClassAlias("EquipManager", EquipManager);
			registerClassAlias("RoleDynamicVo", RoleDynamicVo);
			registerClassAlias("Dictionary", Dictionary);
			registerClassAlias("SkillManager", SkillManager);
			registerClassAlias("GameEventDispatcher", GameEventDispatcher);
			
			addEventListener(Event.ADDED_TO_STAGE,onInit);
			//初始化组件
		}
		
		protected function onInit(event:Event):void
		{
			App.init(this);
			//加载语言包，语言包可以做压缩或加密，这里为了简单直接用xml格式
			App.loader.loadTXT("en.xml", new Handler(loadLang));
			//加载资源			
			App.loader.loadAssets(["assets/comp.swf", "assets/map.swf", "assets/nav.swf", "assets/other.swf", "assets/vector.swf","assets/xinzhi_common.swf"], new Handler(loadCompleteLee), new Handler(loadProgress));
			//加载配置和数据文件
			loadConfigAndDataFiles();
			
			removeChild(bm);
		}
		
		/**
		 * 加载各种数据表并初始化 
		 * 
		 */
		private function loadConfigAndDataFiles():void
		{
			GameDataConfigManager.getInstance().startLoadConfig(loadCompleteLee);
		}
		
		/**测试多语言*/
		private function loadLang(content:*):void {
			var obj:Object = {};
			var xml:XML = new XML(content);
			for each (var item:XML in xml.item) {
				obj[item.@key] = String(item.@value);
			}
			//设置语言包
			App.lang.data = obj;
		}
		
		private function loadProgress(value:Number):void {
			//加载进度
			//trace("loaded", value);
		}
		private var flag:int = 0;
		private function loadCompleteLee():void {
			
			//有可能需要侦听数据 和 素材 双资源加载完毕    todo
			flag++;
			if(flag == 2){
				loadAllComplte();
			}
			
//			addChild(new GameStage());
		}
		
		
		private function loadAllComplte():void{
			gameStart();
		}
		
		/**
		 * 游戏开始 
		 * 
		 */
		private function gameStart():void
		{
			stageInit();
			
			controllerInit();
		}
		private function stageInit():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			//setDesignResolutionSize(800,480,kResolutionNoBorder);  //..没有黑边最重要 ，直接拉伸
			
			stage.align = StageAlign.TOP_LEFT;
			Global.stage = this.stage;
			Global.stage.addChildAt(Global.gameStage,1);
			
			var s:Stats = new Stats();
			App.log.addChild(s);//stats
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			stage.addEventListener(Event.RESIZE,onResize);
//			_setXY();
		}
		
		protected function onResize(event:Event):void
		{
//			_setXY();
		}
		/**
		 * 重构，单拉进入mainController中 
		 *   todo
		 */
		private function controllerInit():void
		{
			MainController.getInstance();
			
			BattleController.getInstance();
			
			MainPageController.getInstance();
			
			RolePageController.getInstance();
			
			SkillPageController.getInstance();
			
			LoginController.getInstance().popUpView();
			
			SweepStakeController.getInstance();
			
			NetworkManager.getInstance();
			NetworkManager.getInstance().sendMessage(0,"hello",-1);
			
		}
		private function _setXY():void 
		{
			trace(Global.stage.fullScreenWidth , Global.stage.fullScreenHeight)
			if((Global.stage.fullScreenWidth / Global.stage.fullScreenHeight) > (Global.FullScreenWidth/ Global.FullScreenHeight))
			{
				if(Global.stage.fullScreenHeight > Global.FullScreenHeight) // 屏幕高宽大于游戏
				{
					Global.gameStage.x = (Global.stage.fullScreenWidth - Global.FullScreenWidth) / 2;
					Global.gameStage.y = (Global.stage.fullScreenHeight - Global.FullScreenHeight) / 2;
				}
				else if(Global.stage.fullScreenWidth > Global.FullScreenWidth) // 屏幕高小于游戏，宽大于游戏
				{
					Global.gameStage.x = (Global.stage.fullScreenWidth - Global.FullScreenWidth * Global.stage.fullScreenHeight / Global.FullScreenHeight) / 2;
					Global.gameStage.y = 0;
				}
				else // 屏幕高宽皆小于游戏
				{
					Global.gameStage.x = (Global.stage.fullScreenWidth - Global.FullScreenWidth * Global.stage.fullScreenHeight / Global.FullScreenHeight) / 2;
					Global.gameStage.y = 0;					
				}
			}
			else
			{
				if(Global.stage.fullScreenWidth > Global.FullScreenWidth)
				{
					Global.gameStage.x = (Global.stage.fullScreenWidth - Global.FullScreenWidth) / 2;
					Global.gameStage.y = (Global.stage.fullScreenHeight - Global.FullScreenHeight) / 2;
				}
				else if(Global.stage.fullScreenHeight > Global.FullScreenHeight)
				{
					Global.gameStage.x = 0;
					Global.gameStage.y = (Global.stage.fullScreenHeight - Global.FullScreenHeight * Global.stage.fullScreenWidth / Global.FullScreenWidth) / 2;
				}
				else
				{
					Global.gameStage.x = 0;
					Global.gameStage.y = (Global.stage.fullScreenHeight - Global.FullScreenHeight * Global.stage.fullScreenWidth / Global.FullScreenWidth) / 2;
				}				
			}
			trace(Global.gameStage.x,Global.gameStage.y);
		}
		
	}
}
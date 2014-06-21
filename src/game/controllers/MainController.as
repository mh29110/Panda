package game.controllers
{
	import flash.net.SharedObject;
	
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.managers.GameDataConfigManager;
	import game.managers.GoodsListManager;
	import game.models.goodsVo.GoodsDynamic;
	import game.models.goodsVo.RetrieveGoodsUtils;
	import game.models.roles.Player;
	import game.models.roles.RoleBasicVo;
	import game.models.roles.UserDataProxy;
	import game.view.MainMenu;

	/**
	 * 存档相关，辅助流程控制 
	 * @author leejia
	 * 
	 */
	public class MainController extends Controller
	{
		public function MainController()
		{
			super();
			initListeners();
		}
		
		private function initListeners():void
		{
			dispatcher.addEventListener(GameEventName.LOGIN_EVENT,onEnterGame);
		}
		
		/**
		 * discard
		 * 如果缓存内有角色，则直接开始游戏
		 * 如果没有 ，则创建角色 
		 * @param event
		 * 
		 */
		private function onEnterGame(event:EventWithData):void
		{
			//此处判定 是否已经存在角色
			//根据 user 的id passward 在 “数据库”中 检索信息  ，再读入user中
			//todo
			var user:RoleBasicVo = UserDataProxy.getInstance().user_1.roleBasicVo = event.data as RoleBasicVo;
			
			if(user.hasCharacter == false)
			{
				//如果还没有角色，则从缓存中读取
				popUpMainMenu();				
			}
			else
			{
				dispatcher.dispatchEvent(new EventWithData(GameEventName.READY_INTO_GAME));
			}
		}
		
		public function popUpMainMenu():void
		{
			loadingSharedObject();
			
			Global.gameStage.addChild(mainMenu);
		}
		private var heroObj:Object = {};	//缓存的对象
		private var isSetted:Boolean = true;
		/**
		 * 从sharedObject载入数据 ，并初始化 
		 * 存档相关
		 */
		private function loadingSharedObject():void
		{
			/*SharedObject.preventBackup(false);*/  //针对ios设备备份so
			_localSharedObject = SharedObject.getLocal("localCache");
			if(_localSharedObject.size == 0)
			{	
				isSetted = false;
			}
			else
			{
				if(_localSharedObject.data["set"] != 1){
					isSetted = false;
				}
			}
			
//			if(!isSetted){
			if( Global.IS_NEW_PROFILES)
			{  //测试缓存用
				newHeroObj();
			}
			else
			{
				//todo
				//从so中读取等级和经验来初始化UserDataProxy.
				UserDataProxy.getInstance().initFromSO( _localSharedObject.data["level"],_localSharedObject.data["exp"],
					_localSharedObject.data["gold"],_localSharedObject.data["bagGridNum"]);
				
				
				//此处可根据等级或者写死了有几个user ，即熊猫，做循环提取
				UserDataProxy.getInstance().user_1 = _localSharedObject.data[ "hero" ];
				UserDataProxy.getInstance().user_2 = _localSharedObject.data[ "hero2" ];
				UserDataProxy.getInstance().user_3 = _localSharedObject.data[ "hero3" ];
				
				GoodsListManager.getInstance().goods = _localSharedObject.data["goodsList"];
				
				if ( isSetted )
				{
					trace( "缓存设置过~~~~~~~~~~~~" );
				}
				else{
					trace( "没有设过缓存！！！！！！！！！" );
				}
			}
		}
		
		///////////////////\是否需要进行sharedObject的侦听    todo
		/*try
		{
			mm = SharedObject.getLocal( "hsxy" + ConfigManager.ip );
			mm.data.gameName = "hsxy" + ConfigManager.ip;
			var flushStatus:String = mm.flush( 10000000000 );
			if ( flushStatus == SharedObjectFlushStatus.PENDING )
			{
				mm.addEventListener( NetStatusEvent.NET_STATUS , onNetStatusHandler );
			}
			else
			{
				_loaclSharedObject.data[ "set" ] = "1";
			}
		}
		catch ( e:Error )
		{
			Security.showSettings( SecurityPanel.LOCAL_STORAGE );
			canWrite = false;
			//	flush();
		}*/
		
		
		/*private function onNetStatusHandler( evt:NetStatusEvent ):void
		{
			if ( evt.info.code == "SharedObject.Flush.Failed" ) /////玩家点击拒绝
			{
				_loaclSharedObject.data[ "set" ] = "0";
				canWrite = false;
			}
			else
			{
				_loaclSharedObject.data[ "set" ] = "1";
				flush();
			}
			mm.removeEventListener( NetStatusEvent.NET_STATUS , onNetStatusHandler );
			mm = null;
		}*/

		////////////////////\
		
		/**
		 * 缓存中没有的话，游戏数据从这里开始展开 
		 * 
		 */
		private function newHeroObj():void
		{
			trace("MainController.newHeroObj()" + "本次是重新创建的档案");
			
			UserDataProxy.getInstance().user_1 = new Player(1);//第一只熊猫数据
			UserDataProxy.getInstance().initFromSO(1,0,10000); 
			UserDataProxy.getInstance().user_1.roleBasicVo.name = "烈火";
			UserDataProxy.getInstance().user_1.roleBasicVo.baseAttribute = 1;
			UserDataProxy.getInstance().user_1.equipManager.addEquip(GameDataConfigManager.getInstance().goodsList['2'].type,RetrieveGoodsUtils.GoodsBasic2Dynamic(2));
			UserDataProxy.getInstance().user_1.equipManager.addEquip(GameDataConfigManager.getInstance().goodsList['1'].type,RetrieveGoodsUtils.GoodsBasic2Dynamic(1));
			UserDataProxy.getInstance().user_1.equipManager.addEquip(GameDataConfigManager.getInstance().goodsList['5'].type,RetrieveGoodsUtils.GoodsBasic2Dynamic(5));
			
			UserDataProxy.getInstance().user_2 = new Player(2);
			UserDataProxy.getInstance().user_2.roleBasicVo.name = "烈酒";
			UserDataProxy.getInstance().user_2.roleBasicVo.baseAttribute = 0;
			UserDataProxy.getInstance().user_2.equipManager;
			
			UserDataProxy.getInstance().user_3 = new Player(3);
			UserDataProxy.getInstance().user_3.roleBasicVo.name = "烈女";
			UserDataProxy.getInstance().user_3.roleBasicVo.baseAttribute = 2;
			UserDataProxy.getInstance().user_3.equipManager;
			
			/*var byteAr:ByteArray = new ByteArray();
			var player:Player = UserDataProxy.getInstance().user_1;
			byteAr.writeObject(UserDataProxy.getInstance().user_1);
			byteAr.position = 0;
			_localSharedObject.data["hero"] = byteAr;
			_localSharedObject.data["set"] = 1; */
			
			var player:Player = UserDataProxy.getInstance().user_1;
			_localSharedObject.data["hero"] = player;
			
			var player2:Player = UserDataProxy.getInstance().user_2;
			_localSharedObject.data["hero2"] = player2;
			
			var player3:Player = UserDataProxy.getInstance().user_3;
			_localSharedObject.data["hero3"] = player3;
			
			
			_localSharedObject.data["set"] = 1;
			
			
			GoodsListManager.getInstance().addGoods(RetrieveGoodsUtils.GoodsBasic2Dynamic(8));
			_localSharedObject.data["goodsList"] = GoodsListManager.getInstance().goods;			
		}
		
		
		/**
		 * 当 升级，特殊等引起基础属性变化时
		 * 当 装备变化时 
		 * 当 技能变化时  ；	以上变化都在计算总值后调用存档
		 * 
		 * 当物品变化时 ;单独调用存档
		 */
		public function saveSharedObject():void{
			//存档需注意，以物品列表为例：本存档是直接存储的实例信息，并非存储的物品id，所以读取时不需要再从物品索引表中重新生成物品
			//也就是原有物品不会随物品xml动态改变。而新生成的道具则会变化
			
			
			//装备技能 在此  &  升级时数据改变在此
			
			BattleController.getInstance().setFullHealth();//存档满血
			
			_localSharedObject.data["hero"] = UserDataProxy.getInstance().user_1;
			_localSharedObject.data["hero2"] = UserDataProxy.getInstance().user_2;
			_localSharedObject.data["hero3"] = UserDataProxy.getInstance().user_3;
			_localSharedObject.data["set"] = 1;
			
			//物品在此  
			var goodsList:Vector.<GoodsDynamic> = GoodsListManager.getInstance().goods;
			_localSharedObject.data["goodsList"] = goodsList;	
			
			//升级时
			_localSharedObject.data["level"] = UserDataProxy.getInstance().level;
			_localSharedObject.data["exp"] = UserDataProxy.getInstance().exp;
			//金币何时变化？
			_localSharedObject.data["gold"] = UserDataProxy.getInstance().gold;
			
			_localSharedObject.data["bagGridNum"] = UserDataProxy.getInstance().bagGridNum;
			
			_localSharedObject.flush();
			
		}
		
		///-------------------单独存档区 ---------------//
		public function saveBagGrids2Local():void{
			/*_localSharedObject.data["bagGridNum"] = UserDataProxy.getInstance().bagGridNum;*/
			
			
			_localSharedObject.flush();
		}
		
		
		private static var _instance:MainController;
		private var _mainMenu:MainMenu;

		private var _localSharedObject:SharedObject;
		public static function getInstance():MainController
		{
			return _instance ||= new MainController();
		}
		
		public function get mainMenu():MainMenu
		{
			if(!_mainMenu)
			{
				_mainMenu = new MainMenu();
			}
			return _mainMenu;
		}
		
		public function set mainMenu(value:MainMenu):void
		{
			_mainMenu = value;
		}
	}
}
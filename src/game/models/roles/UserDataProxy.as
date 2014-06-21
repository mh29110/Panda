package game.models.roles
{
	import game.controllers.GameEventDispatcher;
	import game.controllers.MainController;
	import game.controllers.RolePageController;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.managers.GameDataConfigManager;
	import game.managers.GoodsListManager;
	import game.models.goodsVo.GoodsDynamic;
	import game.models.proxys.GameProxy;
	import game.models.roles.bag.BagConfig;
	
	public class UserDataProxy extends GameProxy
	{
		public var user_1:Player;
		public var user_2:Player;
		public var user_3:Player;
		
		public static const CHANGEEXP:String = "changeExp";
		
		public static const CHANGE_JIN:String = "changeJin";
		public static const CHANGE_YIN:String = "changeYin";
		
		public function UserDataProxy()
		{
			//物品管理器
			GoodsListManager.getInstance().init();
			
			
			initListeners();
		}
		
		/**
		 * 当从sharedObject中读取设置时，初始化各种参数： lvl ,exp 
		 * 不走setter ，更直接，
		 * 也不能走setter ，因为触发的事件会引发错误。
		 * 背包格子数初始化为 {25}
		 */
		public function initFromSO( $lvl:int , $exp:int ,$glod:int, $bagGridNum = BagConfig.BAG_INIT_GRID_NUM):void{
			_level = $lvl;   
			_exp = $exp;
			_gold = $glod;
			_bagGridNum = $bagGridNum;
		}
		private function initListeners():void
		{
			
			//熊猫共享等级和经验？
			dispatcher.addEventListener(GameEventName.LEVEL_UPGRADE,onLevelUp);
			dispatcher.addEventListener(GameEventName.GOODS_USE_EVENT,onUseGoodsHanlder);
			dispatcher.addEventListener(GameEventName.GOODS_SALE,onSaleGoods);
		}
		
		private function onSaleGoods(event:EventWithData):void
		{
			var saled:GoodsDynamic = event.data.data as GoodsDynamic;
			GoodsListManager.getInstance().removeGoods(saled);
			gold += saled.sale;
			saled = null;
			RolePageController.getInstance().rolePage.refreshBagData();
		}
		
		/**
		 * 使用物品handler  
		 * @param event
		 * 
		 */
		private function onUseGoodsHanlder(event:EventWithData):void
		{
			var cPlayer:Player = this["user_"+(event.data.heroIndex+1)];//物品使用对象
			
			
			var goods:GoodsDynamic = event.data.data as GoodsDynamic;
			switch(goods.subtype)//写死为1
			{
				case 1://如果是装备，进行穿戴操作，并刷新人物装备栏 ，提示框。、目前只有装备
				{
					if(UserDataProxy.getInstance().level < goods.canLvl){
						trace("等级不够，无法装备"); 
						return ;
					}
					var removed:GoodsDynamic = cPlayer.equipManager.removeEquip(goods.type);
					cPlayer.equipManager.addEquip(goods.type,goods);
					
					/*GoodsListManager.getInstance().addGoods(removed);*/// bug- 在EquipManager.removeEquip中已经整合了这部分
					
					RolePageController.getInstance().rolePage.refreshBagData();
					RolePageController.getInstance().rolePage.refreshEquipments();
					break;
				}
				case 2:// use goods ,remove from goodslist 
				{
					break;
				}
					
			}
		}
		
		/**
		 * 升级事件  
		 * e.data = next lvl
		 * 
		 */
		private function onLevelUp(e:EventWithData):void
		{
			dispatcher.dispatchEvent(new EventWithData(RoleBasicVo.LEVEL_UPDATE_TO_CHANGE_PROPERTY,int(e.data)));
		}		
		
		private static var _instance:UserDataProxy;
		
		
		public static function getInstance():UserDataProxy
		{
			return _instance ||= new UserDataProxy();
		}
		
		///////////////////////////////////\
		
		private var _exp:uint = 0;//经验
		protected var _level:uint = 0;
		private var  _gold:uint = 0;
		private var _bagGridNum:uint = 25;// 当前已购买的背包格子上限
		//////////////////////////////////////////////////
		public function get level():uint
		{
			return _level;
		}
		
		public function set level(value:uint):void
		{
			if(value != level){
				_level = value;
				GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.LEVEL_UPGRADE,_level));
			}
		}
		
		
		public function get exp():uint
		{
			return _exp;
		}
		
		public function set exp(value:uint):void
		{
			_exp = value;
			if(_exp > GameDataConfigManager.getInstance().rolesProfiles[level].exp)
			{
				exp = _exp - GameDataConfigManager.getInstance().rolesProfiles[level].exp;//递归？
				level ++;
			}
			dispatcher.dispatchEvent(new EventWithData(GameEventName.EXP_GOLD_CHANGE,{type:exp}));
		}

		public function get gold():uint
		{
			return _gold;
		}

		public function set gold(value:uint):void
		{
			_gold = value;
			dispatcher.dispatchEvent(new EventWithData(GameEventName.EXP_GOLD_CHANGE,{type:gold}));//todo发送全局事件，更新悬浮状态栏
		}

		/**
		 *当前已购买的背包格子上限 
		 * @return 
		 * 
		 */
		public function get bagGridNum():uint
		{
			return _bagGridNum;
		}

		public function set bagGridNum(value:uint):void
		{
			_bagGridNum = value;
			
			MainController.getInstance().saveSharedObject();
		}

		
	}
}
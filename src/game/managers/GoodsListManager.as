package game.managers
{
	import flash.events.IEventDispatcher;
	
	import game.controllers.GameEventDispatcher;
	import game.controllers.MainController;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.goodsVo.GoodsDynamic;
	import game.models.roles.UserDataProxy;
	
	public class GoodsListManager extends GameEventDispatcher
	{
		private var _goods:Vector.<GoodsDynamic> = new Vector.<GoodsDynamic>();
		
		/**
		 * 初始化物品列表 
		 * 
		 */
		public function init():void
		{
			
		}
		
		/**
		 * 向列表内增加一个物品 
		 * @param item
		 * @return 
		 * 
		 */
		public function addGoods(item:GoodsDynamic):Boolean{
			if(!item) return false;
			
			if( goods.length == UserDataProxy.getInstance().bagGridNum )
			{
				trace("背包已满");
				return false;
			}
			
			goods.push(item);
			sendGoodsListChangeEvent();		
			return true;
		}
		/**
		 * 移除一个物品，并排序 
		 * @param item
		 * @return 
		 * 
		 */
		public function removeGoods(item:GoodsDynamic):Boolean{
			if(!item) return false;
			if(goods.indexOf(item) == -1) return false; //以上，物品不存在，或者物品不在背包，return false
			goods.splice(goods.indexOf(item),1);
			
			
			sendGoodsListChangeEvent();		
			return true;
		}
		
		
		public function GoodsListManager(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		private static var _instance:GoodsListManager;
		public static function getInstance():GoodsListManager
		{
			return _instance ||= new GoodsListManager();
		}
		public function get goods():Vector.<GoodsDynamic>
		{
			return _goods;
		}
		
		public function set goods(value:Vector.<GoodsDynamic>):void
		{
			if(_goods != value){
				_goods = value;
				sendGoodsListChangeEvent();		
			}
		}
		
		/**
		 * send event and save so 
		 * 
		 */
		private function sendGoodsListChangeEvent():void{
			GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.SORT_GOODS_SIT));
			
			MainController.getInstance().saveSharedObject();
		}
	}
}
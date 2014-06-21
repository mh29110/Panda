package game.view.dialogs {
	import flash.events.MouseEvent;
	
	import game.controllers.GameEventDispatcher;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.goodsVo.GoodsDynamic;
	import game.models.roles.Player;
	import game.models.roles.UserDataProxy;
	import game.ui.dialogs.GoodsCompareDialogUI;
	
	import morn.core.components.Button;
	import morn.core.handlers.Handler;
	
	/**
	 * 对话框测试
	 */
	public class GoodsInfoDialog extends GoodsCompareDialogUI {
		private static var _instance:GoodsInfoDialog;
		
		public function GoodsInfoDialog() {
			
			
		}
		/**默认按钮处理*/
		override protected function onClick(e:MouseEvent):void {
			var btn:Button = e.target as Button;
			if (btn) {
				switch (btn.name) {
					case CLOSE:
						close(btn.name);
						break;
					case CANCEL: 
					case SURE: 
					case NO: 
						GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.GOODS_SALE,_data));
						close(btn.name);
						break;
					case OK: 
						if(UserDataProxy.getInstance().level < _data.data.canLvl){
							trace("等级不够，无法装备");
							showTxt.text += "等级不够，无法装备";
							return ;
						}
						GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.GOODS_USE_EVENT,_data));
						close(btn.name);
						break;
					case YES: 
						
						break;
				}
			}
		}
		private var _data:Object;
		public function pushData(type:int,item:Object = null,closeFunc:Function=null):void{
			resetView();
			
			if(!item) _data = null;
			else _data = item;
			
			if(type == 1)// 查看身上的装备
			{	
				showEquipCompareInfo();
				return;
			}else {
				goodsIcon.url = _data.data.icon;   // 好吧以后要加上类型强转
				showTxt.text = _data.data.name + "\n" +  _data.data.randomFlag +"随机属性id\n" + _data.data.canLvl + "\n" /*+ _data.randomAttributeId1*/+ "\n" +_data.data.id;
				showEquipCompareInfo();
			}
			
			
		
			if(closeFunc){
				closeHandler = new Handler(closeFunc);
			}
		}
		
		private function resetView():void
		{
			equipinfo.text = "";
			showTxt.text = "";
			goodsIcon.url = "";
			equipIcon.url = "";
		}
		
		private function showEquipCompareInfo():void
		{
			var goods:GoodsDynamic = _data.data as GoodsDynamic;
			var cPlayer:Player = UserDataProxy.getInstance()["user_"+(_data.heroIndex+1)];//物品使用对象
			var equip:GoodsDynamic = cPlayer.equipManager.equipments[goods.type];
			if(equip){
				equipinfo.text = "equip:" + equip.name + "\n攻击" + equip.attack + "\n" +equip.id ;
				equipIcon.url = equip.icon;				
			}
		}
		
		/**单例*/
		public static function get instance():GoodsInfoDialog {
			if (_instance) {
				return _instance;
			} else {
				return _instance = new GoodsInfoDialog();
			}
		}
	}
}
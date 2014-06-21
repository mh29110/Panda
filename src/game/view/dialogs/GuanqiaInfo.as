package game.view.dialogs
{
	import flash.events.MouseEvent;
	
	import game.controllers.BattleController;
	import game.models.guanqia.RiskPassDataProxy;
	import game.models.roles.UserDataProxy;
	import game.ui.dialogs.GuankaInfoUI;
	
	import morn.core.components.Button;
	import morn.core.handlers.Handler;
	
	public class GuanqiaInfo extends GuankaInfoUI
	{
		private  var _index:int;//本关卡索引
		
		public function GuanqiaInfo()
		{
			super();
//			closeHandler = new Handler(enterBattleView);此处不需要自己指定，只需要重写onClick方法，否则两者同时触发。
			//重写onClick方法时注意break
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
						close(btn.name);
						break;
					case SURE: 
						close(btn.name);
						break;
					case NO: 
						close(btn.name);
						break;
					case OK: 
						if(UserDataProxy.getInstance().level >= cGuanqiaConfig.canLvl //检测等级和金钱
							&& UserDataProxy.getInstance().gold >= cGuanqiaConfig.canGold)
						{
							UserDataProxy.getInstance().gold -= cGuanqiaConfig.canGold;
							BattleController.getInstance().cMonsters = RiskPassDataProxy.getInstance().getQuanqiaMonstersByIndex(index);
							BattleController.getInstance().startFighting();
							close(btn.name);
						}else{
							trace("GuanqiaInfo.onClick(e) + 钱经验  。进不去");
							guanqiaInfo.text = cGuanqiaConfig.explain +"\n 需要等级"
								+ cGuanqiaConfig.canLvl + "\n需要金币" + cGuanqiaConfig.canGold
								+ " \n 钱or经验 不够 ！进不去！";
						}
						break;
					case YES: 
						close(btn.name);
						break;
				}
			}
		}
		private static var _instance:GuanqiaInfo;
		/**单例*/
		public static function get instance():GuanqiaInfo {
			if (_instance) {
				return _instance;
			} else {
				return _instance = new GuanqiaInfo();
			}
		}
		public function get index():int
		{
			return _index;
		}
		/**
		 * 当设置关卡时刷新数据显示 
		 * @param value
		 * 
		 */
		public function set index(value:int):void
		{
			if(value == _index) return ;
			_index = value;
			
			refreshQuanqiaInfo(_index);
			
		}
		
		private var cGuanqiaConfig:Object;
		/**
		 * 刷新关卡信息显示 
		 * @param _index
		 * 
		 */
		private function refreshQuanqiaInfo(_index:int):void
		{
			var config:Object = RiskPassDataProxy.getInstance().riskConfig[_index-1];
			cGuanqiaConfig = config;
			nameTxt.text = config.name;
			guanqiaInfo.text = config.explain +"\n 需要等级"
				+ config.canLvl + "\n需要金币" + config.canGold;
					
		}
		
	}
}
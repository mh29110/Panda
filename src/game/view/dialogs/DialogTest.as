package game.view.dialogs {
	import flash.events.MouseEvent;
	
	import game.controllers.BattleController;
	import game.ui.dialogs.DialogTestUI;
	
	import morn.core.components.Button;
	import morn.core.handlers.Handler;
	
	/**
	 * 对话框测试
	 */
	public class DialogTest extends DialogTestUI {
		private static var _instance:DialogTest;
		
		public function DialogTest() {
		}
		
		
		/**默认按钮处理*/
		override protected function onClick(e:MouseEvent):void {
			var btn:Button = e.target as Button;
			if (btn) {
				switch (btn.name) {
					case CLOSE: 
						BattleController.getInstance().dispose();
					case CANCEL: 
					case SURE: 
					case NO: 
					case OK: 
					case YES: 
						close(btn.name);
						break;
				}
			}
		}
		
		/**单例*/
		public static function get instance():DialogTest {
			if (_instance) {
				return _instance;
			} else {
				return _instance = new DialogTest();
			}
		}
	}
}
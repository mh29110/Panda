package game.view.dialogs
{
	import game.ui.dialogs.SettingUI;
	
	public class Setting extends SettingUI
	{
		private static var _instance:Setting;
		public function Setting()
		{
			super();
			
		}
		/**单例*/
		public static function get instance():Setting {
			if (_instance) {
				return _instance;
			} else {
				return _instance = new Setting();
			}
		}
	}
}
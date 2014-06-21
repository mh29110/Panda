package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class Global
	{
		public static var stage:Stage ;
		public static var gameStage:Sprite = new Sprite();
		public static var FullScreenHeight:uint = 640;
		public static var FullScreenWidth:uint = 960;
		
		public static const IS_NEW_PROFILES:Boolean = true;// false 读取缓存，  true 创建新档案
		
		public static const ASSET_FOLDER:String = "myAssets/";
		
		public static const isSingleGame:Boolean = true;//测试版不需要登录和创建
		
		public function Global()
		{
			
		}
		
	}
}
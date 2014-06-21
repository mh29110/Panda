package game.view
{
	import flash.events.MouseEvent;
	
	import game.controllers.GameEventDispatcher;
	import game.controllers.SkillPageController;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.ui.MainPageUI;
	import game.view.dialogs.GuanqiaInfo;
	import game.view.dialogs.Setting;
	
	import morn.core.handlers.Handler;
	
	public class MainPage extends MainPageUI
	{
		public function MainPage()
		{
			super();
			
			initListeners();
			
			refreshData();
		}
		
		/**
		 * 填充关卡数据 
		 * 
		 */
		private function refreshData():void
		{
			guanqiaList.dataSource = [{label:"one"},{label:"two"},{label:"boss"}];
		}
		
		private function initListeners():void
		{
			settingIcon.addEventListener(MouseEvent.CLICK,onSettingHandler);
			roleIcon.clickHandler = new Handler(onRoleOpenHandler);
			skillIcon.clickHandler = new Handler(onSkillOpenHandler);
			choujiangIcon.clickHandler = new Handler(onChoujiangHandler);
			rankIcon.addEventListener(MouseEvent.CLICK,onRankHandler);
			
		
			guanqiaList.selectHandler = new Handler(onSelectGuanqiaHanlder);
			
		}
		
		/**
		 * list选择关卡
		 * @param index
		 * 
		 */
		private function onSelectGuanqiaHanlder(index:int):void
		{
			if(index == -1) return;
			GuanqiaInfo.instance.index = index+1;
			GuanqiaInfo.instance.show();
			guanqiaList.selectedIndex = -1;
		}
		
		
		protected function onRankHandler(event:MouseEvent):void
		{
			trace("MainPage.onRankHandler(event)");
		}
		
		protected function onChoujiangHandler():void
		{
			trace("MainPage.onChoujiangHandler(event)");
			GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.SHOW_SWEEPSTAKE_VIEW));
		}
		
		protected function onSkillOpenHandler():void
		{
			SkillPageController.getInstance().onShowPage();
		}
		
		protected function onRoleOpenHandler():void
		{
			GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.ROLE_Page_SHOW));	
		}
		
		protected function onSettingHandler(event:MouseEvent):void
		{
			Setting.instance.popup();
		}
	}
}
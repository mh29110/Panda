package game.view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.dns.AAAARecord;
	
	import game.controllers.GameEventDispatcher;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.roles.RoleBasicVo;
	import game.ui.LoginViewUI;
	
	import morn.core.handlers.Handler;
	
	public class LoginView extends LoginViewUI
	{
		public function LoginView()
		{
			super();
			initListeners();
		}
		
		private function initListeners():void
		{
			loginBtn.addEventListener(MouseEvent.CLICK,onLoginCommit);
		}
		
		private function onLoginCommit(e:MouseEvent):void
		{
			
			//debug  不输入也可以确定
			/*if( !idInput.text) return ; 
			if( !pswInput.text) return ;*/ 
			var user:RoleBasicVo = new RoleBasicVo();
			user.name = idInput.text;
//			user.passWard = int(pswInput.text);
			var evt:EventWithData = new EventWithData(GameEventName.LOGIN_EVENT,user);
			
			GameEventDispatcher.getInstance().dispatchEvent(evt);
		}
		/**
		 * 释放资源 
		 * 
		 */
		public function dispose():void{
			//tobecontinue
			loginBtn.removeEventListener(MouseEvent.CLICK,onLoginCommit);
			if(this.parent){
				parent.removeChild(this);
			}
		}
	}
}
/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class LoginViewUI extends View {
		public var loginBtn:Button;
		public var idInput:TextInput;
		public var pswInput:TextInput;
		protected var uiXML:XML =
			<View>
			  <Image url="png.comp.bg" x="260" y="109" width="368" height="149"/>
			  <Button label="登录" skin="png.other.btn_yellow" x="430" y="293" var="loginBtn" height="36" width="100" labelSize="20"/>
			  <TextInput skin="png.comp.textinput" x="404" y="162" width="200" height="36" align="center" size="20" maxChars="12" var="idInput" toolTip="请输入用户名,XX字以上"/>
			  <TextInput skin="png.comp.textinput" x="404" y="212" width="200" height="36" align="center" size="20" maxChars="12" var="pswInput" asPassword="true" toolTip="xx数字以内" restrict="0-9a-zA-Z"/>
			  <Label text="用户名" x="283" y="162" height="36" width="100" size="20"/>
			  <Label text="密码" x="283" y="212" height="36" width="100" size="20"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
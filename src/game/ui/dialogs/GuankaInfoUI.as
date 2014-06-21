/**Created by Morn,Do not modify.*/
package game.ui.dialogs {
	import morn.core.components.*;
	public class GuankaInfoUI extends Dialog {
		public var nameTxt:Label;
		public var guanqiaInfo:TextArea;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.xinzhi_common.mainPage.guankaInfo" x="0" y="0"/>
			  <Button skin="png.xinzhi_common.mainPage.btn_close" x="380" y="18" width="36" height="34" name="close"/>
			  <Button label="开打！" skin="png.xinzhi_common.btn_confirm" x="176" y="285" width="97" height="34" name="ok"/>
			  <Label text="label" x="142" y="28" width="139" height="25" align="center" var="nameTxt"/>
			  <TextArea text="TextArea" skin="png.comp.textarea" x="63" y="85" width="305" height="155" var="guanqiaInfo"/>
			</Dialog>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
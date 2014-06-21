/**Created by Morn,Do not modify.*/
package game.ui.dialogs {
	import morn.core.components.*;
	public class SettingUI extends Dialog {
		public var testInfo:TextArea;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.xinzhi_common.rank_setting_oddBG" x="0" y="0" width="400" height="300" smoothing="true"/>
			  <Button skin="png.xinzhi_common.mainPage.btn_close" x="346" y="11" name="close"/>
			  <TextArea text="TextArea" skin="png.comp.textarea" x="7" y="56" width="388" height="189" var="testInfo"/>
			</Dialog>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
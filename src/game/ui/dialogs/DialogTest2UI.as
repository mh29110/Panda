/**Created by Morn,Do not modify.*/
package game.ui.dialogs {
	import morn.core.components.*;
	public class DialogTest2UI extends Dialog {
		public var showTxt:TextArea;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" width="400" height="400" sizeGrid="4,26,4,4"/>
			  <Button skin="png.comp.btn_close" x="361" y="3" name="close"/>
			  <Button skin="png.comp.btn_close" x="100" y="300" name="ok" label="装备"/>
			  <Button skin="png.comp.btn_close" x="250" y="300" name="no" label="出售"/>
				
			  <TextArea text="TextArea" skin="png.comp.textarea" x="86" y="80" width="222" height="224" size="20" var="showTxt"/>
			</Dialog>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
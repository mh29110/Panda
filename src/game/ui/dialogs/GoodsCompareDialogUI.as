/**Created by Morn,Do not modify.*/
package game.ui.dialogs {
	import morn.core.components.*;
	public class GoodsCompareDialogUI extends Dialog {
		public var showTxt:TextArea;
		public var dress:Button;
		public var sale:Button;
		public var equipinfo:TextArea;
		public var equipIcon:Image;
		public var goodsIcon:Image;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" width="400" height="400" sizeGrid="4,26,4,4"/>
			  <Button skin="png.comp.btn_close" x="361" y="3" name="close"/>
			  <TextArea text="TextArea" skin="png.comp.textarea" x="220" y="78" width="157" height="234" size="20" var="showTxt"/>
			  <Button label="装备" skin="png.comp.button" x="39" y="322" var="dress" name="ok"/>
			  <Button label="出售" skin="png.comp.button" x="274" y="321" var="sale" name="no"/>
			  <TextArea text="TextArea" skin="png.comp.textarea" x="22" y="77" width="163" height="234" var="equipinfo"/>
			  <Image url="png.comp.blank" x="68" y="39" width="57" height="30" var="equipIcon"/>
			  <Image url="png.comp.blank" x="266" y="39" width="57" height="30" var="goodsIcon"/>
			</Dialog>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
/**Created by Morn,Do not modify.*/
package game.ui.roleUI {
	import morn.core.components.*;
	public class TopUserInfoViewUI extends View {
		public var goldText:Label;
		public var expText:Label;
		public var levelText:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="png.xinzhi_common.float.inputBg" x="18" y="2"/>
			  <Image url="png.xinzhi_common.float.inputBg" x="187" y="3"/>
			  <Image url="png.xinzhi_common.float.inputBg" x="370" y="3"/>
			  <Label text="9999999" x="406" y="17" width="76" height="19" align="left" var="goldText" color="0xffffff"/>
			  <Label text="9999999" x="63" y="17" width="76" height="19" align="left" var="expText" color="0xffffff"/>
			  <Image url="png.xinzhi_common.float.bag" x="162" y="-1"/>
			  <Button skin="png.xinzhi_common.float.btn_buy" x="504" y="6"/>
			  <Image url="png.xinzhi_common.float.gold" x="343" y="0" width="54" height="54"/>
			  <Image url="png.xinzhi_common.float.lvl" x="-4" y="-1"/>
			  <Label text="99" x="7" y="17" width="30" height="20" align="center" var="levelText" color="0xff0000" stroke="4" size="14"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class MainPageUI extends View {
		public var boxiangIcon:Image;
		public var roleIcon:Button;
		public var skillIcon:Button;
		public var choujiangIcon:Button;
		public var settingIcon:Button;
		public var rankIcon:Button;
		public var guanqiaList:List;
		public var guanka_2:Button;
		public var guanka_1:Button;
		public var guanka_boss:Button;
		public var guanka_3:Button;
		public var guanka_5:Button;
		public var guanka_4:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.xinzhi_common.MainUIBG" x="0" y="0" width="960" height="640" visible="true" alpha="1"/>
			  <Image url="png.xinzhi_common.mainPage.baoxiang" x="852" y="8" var="boxiangIcon"/>
			  <Button skin="png.xinzhi_common.mainPage.btn_role" x="5" y="526" labelFont="Arial" labelSize="20" labelStroke="0x0" var="roleIcon"/>
			  <Button skin="png.xinzhi_common.mainPage.btn_skill" x="107" y="527" labelSize="20" labelStroke="0x0" var="skillIcon"/>
			  <Button skin="png.xinzhi_common.mainPage.btn_odd" x="853" y="521" labelSize="20" labelStroke="0x0" var="choujiangIcon"/>
			  <Button skin="png.xinzhi_common.mainPage.btn_setting" x="5" y="2" var="settingIcon"/>
			  <Button skin="png.xinzhi_common.mainPage.btn_rank" x="108" y="1" var="rankIcon"/>
			  <List x="88" y="38" var="guanqiaList">
			    <Button skin="png.xinzhi_common.mainPage.btn_youansenlin" var="guanka_2" x="46" y="104" name="item1"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_aihao" var="guanka_1" name="item0" y="249"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_fengbao" x="227" y="248" var="guanka_boss"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_huangmanbuluo" x="227" y="95" name="item2" var="guanka_3"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_kongjuzhidi" x="312" y="453"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_mofajitan" x="534" y="111"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_mojingshangu" x="356" y="159" var="guanka_5"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_xieshenyiji" x="316" var="guanka_4"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_zuzhoulingmu" x="626" y="320"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_aozhicheng" x="483" y="239"/>
			    <Button skin="png.xinzhi_common.mainPage.btn_siwangzhaoze" x="195" y="372"/>
			  </List>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
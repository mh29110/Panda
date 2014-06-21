/**Created by Morn,Do not modify.*/
package game.ui.sweeps {
	import morn.core.components.*;
	public class SweepStakeViewUI extends Dialog {
		public var commitBtn:Button;
		public var sweepShowList:List;
		public var introduce:Label;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.xinzhi_common.rank_setting_oddBG" x="0" y="0"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="355" y="81"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="430" y="80"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="281" y="155"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="282" y="231"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="355" y="154"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="430" y="155"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="356" y="231"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="430" y="231"/>
			  <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="280" y="82"/>
			  <Button label="抽奖" skin="png.xinzhi_common.btn_confirm" x="326" y="334" var="commitBtn"/>
			  <List x="298" y="99" var="sweepShowList" repeatX="3" repeatY="3" spaceX="16" spaceY="16">
			    <Image url="png.comp.blank" width="55" height="55" name="render"/>
			  </List>
			  <Image url="png.xinzhi_common.gainRole" x="-19" y="21"/>
			  <Label text="label" x="221" y="71" width="304" height="27" var="introduce" color="0x339900"/>
			  <Button skin="png.xinzhi_common.mainPage.btn_close" x="464" y="22" name="close"/>
			</Dialog>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
/**Created by Morn,Do not modify.*/
package game.ui.roleUI {
	import morn.core.components.*;
	public class RolePageUI extends View {
		public var hp:Label;
		public var attack:Label;
		public var speed:Label;
		public var defend:Label;
		public var defendPercent:Label;
		public var attackPercent:Label;
		public var heroImg:Image;
		public var heroName:Label;
		public var equipCon:Container;
		public var equip_1:Image;
		public var equip_2:Image;
		public var equip_3:Image;
		public var equip_4:Image;
		public var equip_5:Image;
		public var equip_6:Image;
		public var equip_7:Image;
		public var bagGoodsList:List;
		public var nextPageBtn:Button;
		public var heroSelectTab:Tab;
		public var close:Button;
		public var btnTezhi:Button;
		public var btnTrim:Button;
		public var backPageBtn:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.xinzhi_common.role_skill_bg" x="-14" y="-15" width="988" height="671"/>
			  <Image url="png.xinzhi_common.RoleUI.pane1" x="126" y="440"/>
			  <Image url="png.xinzhi_common.RoleUI.pane2" x="135" y="89"/>
			  <Image url="png.xinzhi_common.RoleUI.bagbg" x="525" y="83"/>
			  <Image url="png.xinzhi_common.heroIcon" x="7" y="75"/>
			  <Label text="0" x="217" y="461" width="99" height="18" var="hp" color="0x660033" stroke="0x0"/>
			  <Label text="0" x="369" y="456" width="99" height="18" var="attack" color="0x660033" stroke="0x0"/>
			  <Label text="0" x="218" y="489" width="99" height="18" var="speed" color="0x660033" stroke="0x0"/>
			  <Label text="0" x="370" y="488" width="99" height="18" var="defend" color="0x660033" stroke="0x0"/>
			  <Label text="0" x="222" y="566" width="45" height="18" var="defendPercent" color="0x660033" stroke="0x0"/>
			  <Label text="0" x="372" y="568" width="51" height="18" var="attackPercent" color="0x660033" stroke="0x0"/>
			  <Label text="hp:" x="156" y="458" color="0xffff00"/>
			  <Label text="attack:" x="297" y="458" color="0xffff00"/>
			  <Label text="speed:" x="157" y="485" color="0xffff00"/>
			  <Label text="defend:" x="305" y="483" color="0xffff00"/>
			  <Label text="d_percent:" x="140" y="565" color="0xffff00"/>
			  <Label text="a_percent:" x="279" y="567" color="0xffff00"/>
			  <Image url="png.xinzhi_common.RoleUI.PlayerCard" x="185" y="159" disabled="false" smoothing="false" mouseChildren="false" mouseEnabled="false" var="heroImg"/>
			  <Label text="炀炀" x="144" y="102" width="140" height="30" size="20" mouseChildren="false" mouseEnabled="false" align="left" color="0xff0000" var="heroName"/>
			  <Container x="145" y="112" var="equipCon">
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="-21" y="80"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="-21" y="163"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" y="244" x="-21"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="286" disabled="true" y="-1"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="286" y="81"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="286" y="162"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="286" y="246"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="-21" y="81" var="equip_1" name="weapon"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="-21" y="164" var="equip_2" name="defend"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" y="245" var="equip_3" name="shipin_1" x="-21"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="287" var="equip_4" disabled="true" name="onkown" y="-2"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="287" y="80" var="equip_5" name="shipin_2"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="287" y="161" var="equip_6" name="shenqi"/>
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" x="287" y="245" var="equip_7" name="shipin_3"/>
			  </Container>
			  <List x="536" y="91" var="bagGoodsList" spaceX="-12" spaceY="-12" repeatX="5" repeatY="6">
			    <Box name="render" x="0" y="0">
			      <Clip url="png.xinzhi_common.RoleUI.clip_selectBox_k" clipY="2" clipX="1" x="3" y="3" width="78" height="80" name="selectBox"/>
			      <Image url="png.xinzhi_common.RoleUI.CommonIcon" name="icon" x="12" y="11" width="59" height="62"/>
			      <Label x="57" y="53" color="0xffff00" align="right" width="15" height="18" name="label" text="n"/>
			    </Box>
			  </List>
			  <Button label=">>" skin="png.xinzhi_common.RoleUI.btn_paging" x="837" y="537" var="nextPageBtn"/>
			  <Tab labels=",," skin="png.xinzhi_common.RoleUI.tab_roleSelect" x="19" y="91" direction="vertical" var="heroSelectTab"/>
			  <Button skin="png.xinzhi_common.btn_return" x="16" width="187" height="56" var="close" y="15"/>
			  <Button label="重置" skin="png.xinzhi_common.RoleUI.btn_role_skill" x="423" y="538" var="btnTezhi"/>
			  <Button label="整理" skin="png.xinzhi_common.RoleUI.btn_role_skill" x="552" y="538" var="btnTrim"/>
			  <Button label="&lt;&lt;" skin="png.xinzhi_common.RoleUI.btn_paging" x="731" y="539" var="backPageBtn"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
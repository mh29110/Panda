/**Created by Morn,Do not modify.*/
package game.ui.roleUI {
	import morn.core.components.*;
	public class SkillPageUI extends View {
		public var heroSelectTab:Tab;
		public var skillList:List;
		public var skillIcon:Image;
		public var skillName:Label;
		public var skillLvl:Label;
		public var explain:TextArea;
		public var skillUpgrade:Button;
		public var skillCast:Label;
		public var nextExplain:TextArea;
		public var close:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.xinzhi_common.role_skill_bg" x="115" y="52"/>
			  <Image url="png.xinzhi_common.heroIcon" x="1" y="59"/>
			  <Image url="png.xinzhi_common.skill.pane1" x="141" y="77"/>
			  <Image url="png.xinzhi_common.skill.pane2" x="143" y="445"/>
			  <Image url="png.xinzhi_common.skill.pane3" x="658" y="76"/>
			  <Tab labels="  ,  ,  " skin="png.xinzhi_common.RoleUI.tab_roleSelect" x="14" y="77" direction="vertical" var="heroSelectTab"/>
			  <List x="191" y="102" var="skillList" repeatX="4" repeatY="3" spaceX="36" spaceY="20">
			    <Box name="render">
			      <Image url="png.xinzhi_common.RoleUI.CommonIcon" y="22" width="64" height="67" name="icon"/>
			      <Image url="png.comp.image" x="52" width="24" height="30" name="up"/>
			    </Box>
			  </List>
			  <List x="245" y="474" repeatX="3" repeatY="1" spaceX="40">
			    <Box name="render">
			      <Image url="png.xinzhi_common.RoleUI.CommonIcon" y="22" width="64" height="67" name="icon"/>
			      <Image url="png.comp.image" x="52" width="24" height="30" name="up"/>
			    </Box>
			  </List>
			  <Container x="695" y="132">
			    <Image url="png.xinzhi_common.RoleUI.CommonIcon" width="64" height="70" var="skillIcon"/>
			    <Label x="92" y="2" width="90" height="28" var="skillName" align="center" size="20" color="0xff0000" text="技能名称"/>
			    <Label x="120" y="37" width="61" height="28" size="20" var="skillLvl" color="0xff00" align="right" text="等级"/>
			    <TextArea skin="png.comp.textarea" x="12" y="100" width="181" height="112" color="0x0" stroke="0xffffff" mouseChildren="false" mouseEnabled="false" var="explain" text="说明"/>
			    <Button label="升级" skin="png.comp.button" x="58" y="386" var="skillUpgrade"/>
			    <Label x="104" y="338" width="74" height="25" align="left" var="skillCast"/>
			    <TextArea text="下一级说明" skin="png.comp.textarea" x="12" y="227" width="180" height="98" var="nextExplain"/>
			  </Container>
			  <Button skin="png.xinzhi_common.btn_return" x="10" y="8" width="187" height="56" var="close"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
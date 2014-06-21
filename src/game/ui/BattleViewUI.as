/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class BattleViewUI extends View {
		public var fightText:TextArea;
		public var monster:FrameClip;
		public var role:FrameClip;
		public var timer:FrameClip;
		public var close:Button;
		public var layerNum:Label;
		public var heroBar:ProgressBar;
		public var enemyBar:ProgressBar;
		protected var uiXML:XML =
			<View>
			  <Image url="jpg.map.map1" x="6" y="1" scale="0.7" scaleX="0.2" width="4750" height="675.714285714286"/>
			  <TextArea text="战斗记录：" skin="png.comp.textarea" x="7" y="477" width="950" height="155" var="fightText" scrollBarSkin="png.comp.vscroll"/>
			  <FrameClip skin="assets.frameclip_Bear" x="628" y="176" var="monster" scale="2" interval="10"/>
			  <FrameClip skin="assets.frameclip_Bear" x="326" y="176" scale="2" var="role" scaleX="-2" interval="10"/>
			  <Image url="png.other.battle" x="461" y="267"/>
			  <FrameClip skin="assets.frameclip_Clock" x="462" y="342" var="timer"/>
			  <Button skin="png.xinzhi_common.btn_return" x="19" y="12" var="close" width="187" height="56"/>
			  <Image url="png.xinzhi_common.battle.layerNum" x="389" y="406"/>
			  <Label text="第一只" x="411" y="416" width="134" height="38" var="layerNum" color="0xff00" align="center" size="32"/>
			  <Image url="png.xinzhi_common.battle.pgBg" x="101" y="378"/>
			  <Image url="png.xinzhi_common.battle.pgBg" x="592" y="381"/>
			  <ProgressBar skin="png.xinzhi_common.battle.progress" x="108" y="390" var="heroBar"/>
			  <ProgressBar skin="png.xinzhi_common.battle.progress" x="599" y="394" var="enemyBar"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
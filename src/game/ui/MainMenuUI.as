/**Created by Morn,Do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class MainMenuUI extends View {
		public var start:Button;
		public var initBar:ProgressBar;
		protected var uiXML:XML =
			<View>
			  <Button label="马上开始战斗吧！" skin="png.other.btn_red" x="364.5" y="525" width="231" height="32" var="start"/>
			  <ProgressBar skin="png.comp.progress" x="337" y="270" width="277" height="14" var="initBar"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
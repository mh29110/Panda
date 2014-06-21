package game.view
{
	import game.controllers.GameEventDispatcher;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.roles.Player;
	import game.models.roles.UserDataProxy;
	import game.models.skills.SkillInfo;
	import game.ui.roleUI.SkillPageUI;
	
	import morn.core.components.Component;
	import morn.core.components.Image;
	import morn.core.handlers.Handler;
	
	public class SkillPage extends SkillPageUI
	{
		public function SkillPage()
		{
			super();
			close.clickHandler = new Handler(onCloseUIHandler);
			skillList.renderHandler = new Handler(listRender);
			skillList.selectHandler = new Handler(onSelectHandler);
			
			skillUpgrade.clickHandler = new Handler(onUpgradeSkillHandler);
			heroSelectTab.selectHandler = new Handler(onSelectHeroHanlder);
		}
		
		private var heroIndex:int = 1;//默认选择第一个熊猫
		private function onSelectHeroHanlder(index:int):void
		{
				heroIndex = index+1;
				refreshData(heroIndex);
		}
		
		private function onUpgradeSkillHandler():void
		{
			if(skillList.selectedItem){
				if(UserDataProxy.getInstance().gold < skillList.selectedItem.data.cast ) {
					trace("钱不够");
					nextExplain.text += "not enough money";
					return ;
				}
				 if(UserDataProxy.getInstance().level < skillList.selectedItem.data.canLvl){//直接在view中检测金币和等级
					nextExplain.text += "role's level  lower ";
					trace("等级不够");
					return ;
				}
				GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.SKILL_UPGRADE,{hero:heroIndex,id:skillList.selectedItem.data.id}));
			}
		}
		
		/**
		 * 选中技能后，在右边列表中显示信息 
		 * 
		 */
		private function onSelectHandler(index:int):void
		{
			skillIcon.url = skillList.selectedItem.url;
			skillName.text = skillList.selectedItem.data.name;
			skillLvl.text = skillList.selectedItem.data.lvl;
			explain.text = skillList.selectedItem.data.explain;
			skillCast.text = "next cast: " + skillList.selectedItem.data.cast;
			
			
		}
		
		private function onCloseUIHandler():void
		{
			Global.gameStage.removeChild(this);
		}		
		
		
		/**自定义List项渲染*/
		private function listRender(item:Component, index:int):void {
			if (index < skillList.length) {
				var up:Image = item.getChildByName("up") as Image;
				up.alpha = 0.9;
				var icon:Image = item.getChildByName("icon") as Image;
				icon.url = skillList.dataSource[index].url;
				if(skillList.dataSource[index].data.lvl == 0){
					icon.disabled = true;
				}else{
					icon.disabled = false;
				}
			}
		}
		/**
		 * 载入数据 
		 * 
		 */
		public function refreshData(index:int):void
		{
			var skills:Vector.<SkillInfo> = UserDataProxy.getInstance()["user_"+index].skillManager.skillBeidong;
			var arr:Array = [];
			
			var len:int = skills.length;
			for (var i:int = 0; i < len; i++) 
			{
				if( skills[i] == null ) return;
				var o:Object = {};
				o.url = skills[i].icon;
				o.data = skills[i];
				arr[i] = o;
			}
			skillList.dataSource = arr;
			
			if(skillList.selectedItem){
				onSelectHandler(skillList.selectedIndex);
			}
		}
	}
}
package game.view
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.geom.ColorTransform;
	
	import game.models.LiveThing;
	import game.ui.BattleViewUI;
	
	public class BattleView extends BattleViewUI
	{
		public function BattleView()
		{
			super();
			fightText.text += "\n";
			timer.play();
		}
		
		public function fight(index:int,attacker:LiveThing,onAtter:LiveThing,damage:int):void
		{
			if(index == 0)
			{
				role.playFromTo(90,110);
				fightText.text += "玩家"+ attacker.name +"攻击了怪物"+ onAtter.name+",攻击值 " + damage ;
			}else{
				monster.playFromTo(90,110);
				fightText.text += "怪物"+attacker.name+"攻击了" + "玩家"+ onAtter.name +",攻击值" + damage ;
			}
		}
		
		/**
		 * 根据切换动画时间来做切换缓动 
		 * @param time  const 缓动时间
		 * 
		 */
		public function swicthMonster(time:int):void
		{
			TweenMax.to(monster,time/1000/2,{alpha:0,onComplete:back});
			function back():void{
				TweenMax.to(monster,time/1000/2,{alpha:1});
			}
			
			monster.transform.colorTransform = new ColorTransform(Math.random(),Math.random(),Math.random());
		}
		
		/**
		 * todo  
		 * 释放自己
		 */
		public function dispose():void
		{
			/*App.asset.disposeBitmapData("jpg.map.map1");*/
		}
	}
}
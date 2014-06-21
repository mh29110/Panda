package game.controllers
{
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.guanqia.MonsterData;
	import game.models.roles.Player;
	import game.models.roles.UserDataProxy;
	import game.view.BattleView;
	import game.view.dialogs.DialogTest;
	
	import morn.core.handlers.Handler;
	
	public class BattleController extends Controller
	{
		private var _battleView:BattleView;
		
		private const SWITCH_MONSTER_TIME:int = 1000;//转换动画耗时时间 m毫秒
		public function BattleController()
		{
			super();
			initListeners();
		}
		
		private function initListeners():void
		{
			//配合onBattleStart
			dispatcher.addEventListener(GameEventName.LIVE_THING_DEAD,onSomeOneDead);
			
			battleView.close.clickHandler = new Handler(onBattleExitHandler);
		}
		private static var waves:int = 1;
		public function startFighting():void
		{
			waves = cMonsters.length;
			battleView.fightText.text += "当前怪物波：1，还剩" + (waves-1) + "只" ;
			battleView.layerNum.text = "第"+ (waves-1) +"只";
			popUpView();
			
			//coding
			player = UserDataProxy.getInstance().user_1;
			trace("BattleController.startFighting()",player.roleDynamic.hp);
			
			
			if(cMonsters.length > 0){
				currentMonster = cMonsters[cMonsters.length-1];
				startOnceFight();
			}else{
				_battleView.fightText.text = "现在还没刷出怪";
			}
		}
		
		/**
		 * 退出战斗 
		 * 
		 */
		private function onBattleExitHandler():void
		{
			stopOnceFight();
			dispose();
		}
		
		private function onSomeOneDead(evt:EventWithData):void
		{
			
			if(evt.data.type == 0){
				stopOnceFight(0);
				//玩家死
				battleView.fightText.text += "你死了\n";
				//弹出复活界面，抛出复活事件
				showReliveTip();
				
			}else if(evt.data.type == 1){
				stopOnceFight();
				//怪物死
				cMonsters.shift();
				
				updateUserExpGold();
				
				battleView.fightText.text += "   打死了怪物    ";
				if(cMonsters.length>0){
					battleView.fightText.text += "\n 当前怪物波："+ (waves-cMonsters.length + 1) +"，还剩" + (cMonsters.length - 1) + "只\n" ;
					currentMonster = cMonsters[cMonsters.length-1];
					battleView.layerNum.text = "第"+ (waves-cMonsters.length + 1) +"只";
					App.timer.doOnce(SWITCH_MONSTER_TIME,switchDone);
				}else{
					//过关了  showKillAllView();
					battleView.fightText.text += "通关！";
				}
				battleView.swicthMonster(SWITCH_MONSTER_TIME);
			}
		}
		
		/**
		 * 根据公式来计算获取经验和金币，
		 *  怪物金币和经验系数太低了，金币计算值经常为0（不到1）
		 * 此处还没有加入 技能 的影响       -- todo 
		 * 
		 */
		private function updateUserExpGold():void
		{
			//加经验
			var user:UserDataProxy = UserDataProxy.getInstance();
			var tempExp:int = 0;
			if(user.level < currentMonster.level - 5 ){
				tempExp = ( user.level*2 + 20 ) * (1+0.06 *( 5 /*当怪物等级高玩家5级时，写死为5*/ ) ) * currentMonster.expLvl;
			}
			if(user.level <= currentMonster.level && user.level >= (currentMonster.level - 5 )  ){
				tempExp = ( user.level*2 + 20 ) * (1+0.06 *(currentMonster.level - user.level) ) * currentMonster.expLvl;
			}
			if(user.level > currentMonster.level && user.level <= (currentMonster.level+5) ){
				tempExp = ( user.level*2 + 20 ) * (1+0.2 * (currentMonster.level-user.level ) ) * currentMonster.expLvl;
			}
			user.exp += tempExp;
			//加金币
			var tempGold:int = 0;
			if(user.level < currentMonster.level - 5 ){
				tempGold = (1+0.06 *( 5 /*当怪物等级高玩家5级时，写死为5*/ ) ) * currentMonster.goldLvl;
			}
			if(user.level <= currentMonster.level && user.level >= (currentMonster.level - 5 )  ){
				tempGold = (1+0.06 *( currentMonster.level - user.level ) ) * currentMonster.goldLvl;
			}
			if(user.level > currentMonster.level && user.level <= (currentMonster.level+5) ){
				tempGold = (1+0.2 * (currentMonster.level-user.level ) ) * currentMonster.goldLvl;
			}
			user.gold += tempGold;
			trace("增量 in BattleController  = RoleVo.exp   :"+tempExp, "   Rolevo.gold   :"+tempGold);
		}
		//显示复活界面
		private function showReliveTip():void
		{
			DialogTest.instance.popupCenter = true;
			DialogTest.instance.popup();
		}
		
		/**
		 * 换怪物 动画完成
		 * 
		 */
		private function switchDone():void
		{
			startOnceFight();//继续战斗
		}
		/**
		 * 停止战斗原因  0：玩家死  || 1 ：其他原因
		 * 若玩家死则暂时不给怪物回血。 
		 * @param type
		 * 
		 */
		private function stopOnceFight(type:int = 1):void{
			//当一局战斗结束时，如果不是玩家死，则恢复当前怪物血量。  若玩家死则不回复，等他复活，如果不复活退出，则回复血量
			if(type != 0 && currentMonster){ currentMonster.hp = currentMonster.hpMax; };
			
			App.timer.clearTimer(mainFightStep);
		}
		private static const PINLV:uint = 100;
		/**
		 * 杀死一只怪物的单局战斗 
		 * 
		 */
		private function startOnceFight():void{
			//1 重置 计数器
			time = 0;
			//2 计算双方出手频率
			var mSpeed:int = Config.GAME_FPS / (currentMonster.speed/PINLV);//怪物每秒出手次数
			var pSpeed:int = Config.GAME_FPS / (player.roleDynamic.speed/PINLV);//玩家每秒出手次数
			
			App.timer.doLoop(1000/Config.GAME_FPS,mainFightStep,[pSpeed,mSpeed]);
		}
		private var time:int;//计数器
		public function onBattleStart():void
		{
			trace("战斗开始"); 
			popUpView();
			startFighting();
		}
		
		private var player:Player;
		public var cMonsters:Vector.<MonsterData>;
		private var currentMonster:MonsterData;
		
		/**
		 * 主战斗逻辑循环 
		 * 
		 */
		private function mainFightStep(pSpeed,mSpeed):void{
			time++;
			
		
			
			if( time%pSpeed == 0){		//player attack  传入的应该是 战报 信息 ；此处需要进行大量细化  todo
				var damageP:int = (player.roleDynamic.minAttack - currentMonster.minDefend) > 0 ? (player.roleDynamic.minAttack - currentMonster.minDefend) : 1;
				currentMonster.hp -= damageP;
				_battleView.fight(0,player.roleDynamic,currentMonster,damageP);
				battleView.fightText.text += "|| 被攻击剩余血量："  + currentMonster.hp + "\n";
				battleView.enemyBar.value = ( currentMonster.hp/currentMonster.hpMax);	
			}
			if( time%mSpeed == 0 ){// monster attack
				var damageM:int = (currentMonster.minAttack - player.roleDynamic.minDefend) > 0 ? (currentMonster.minAttack - player.roleDynamic.minDefend) : 1;
				player.roleDynamic.hp -= damageM;
				_battleView.fight(1,currentMonster,player.roleDynamic,damageM);
				battleView.fightText.text += "|| 被攻击剩余血量："  + player.roleDynamic.hp + "\n";
				battleView.heroBar.value = ( player.roleDynamic.hp/player.roleDynamic.hpMax);		
			}
		}
		
		private function popUpView():void
		{
			Global.gameStage.addChild(battleView);
		}
		private static var _instance:BattleController;
		
		
		public static function getInstance():BattleController
		{
			return _instance ||= new BattleController();
		}
		
		public function get battleView():BattleView
		{
			if(!_battleView)
			{
				_battleView = new BattleView();
			}
			return _battleView;
		}
		
		public function set battleView(value:BattleView):void
		{
			_battleView = value;
		}
		
		/**
		 * 出战斗，关游戏等 满状态 
		 * 
		 */
		public function setFullHealth():void{
			
			UserDataProxy.getInstance().user_1.roleDynamic.hp = UserDataProxy.getInstance().user_1.roleDynamic.hpMax;
			if(UserDataProxy.getInstance().user_2)
				UserDataProxy.getInstance().user_2.roleDynamic.hp = UserDataProxy.getInstance().user_1.roleDynamic.hpMax;
			if(UserDataProxy.getInstance().user_3)
				UserDataProxy.getInstance().user_3.roleDynamic.hp = UserDataProxy.getInstance().user_1.roleDynamic.hpMax;
		}
		
		/**
		 * 释放掉 
		 * 
		 */
		public  function dispose():void
		{
			stopOnceFight();
			setFullHealth();
			
			if(battleView.parent) {battleView.parent.removeChild(battleView);};
			
			//todo 如果返回后不需要保留关卡信息，则在这里也需要把数据释放掉
			battleView.fightText.text = "";
			
			battleView.dispose();
		}
	}
}
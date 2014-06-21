package game.models.roles
{
	import flash.events.Event;
	
	import game.models.LiveThing;

	/**
	 * 角色 基础属性  
	 * 包括 基础属性、升级带来的属性 
	 * @author leejia
	 * 
	 */
	public class RoleBasicVo extends LiveThing
	{
		public static const LEVEL_UPDATE_TO_CHANGE_PROPERTY:String="property_update"; //技能升级带来属性变化，先通知userDataProxy,
		public static const SPECIAL_PROPERTY_UPDATE:String="special property_update"; 
		
		
		public function RoleBasicVo()
		{
		}
		
		
		/*** 特质相关 
		 * 
		 * 三个整数，代表攻击，hp，速度的百分比加成
		 *  **/
		public var tezhiVector:Vector.<int> = new Vector.<int>();
		
		///////******     dynamic       ****///////////
		
//		public var hp:int;//1
//		public var attack:int;//3
		public var hpPercent:int;//2
		public var attackPercent:int;//4
//		public var minAttack:uint;//5
		public var minAttackPercent:int;//6
//		public var maxAttack:uint;//7
		public var maxAttackPercent:int;//8
		
		public var defend:int;//9
//		public var minDefend:uint;//11
//		public var maxDefend:uint;//13
		
		public var defendPercent:int;//10
		public var minDefendPercent:int//12
		public var maxDefendPercent:int//14
//		public var speed:int ;//15
		public var speedPercent:int;//16
		
		public var baoji:int;//17
		public var baojiDamage:int;//18
		public var baojiDamageless:int;//19
		
		public var damagePercent:int;//20
		public var defendlessPercent:int;//21
		
		public var zhaojia:int;//22
		public var zhaojiaPercent:int;//23
		
		public var damageLessPercent:int;//24
		
		public var luck:int;//25
		
		public var damageBounce:int;//26  反弹一定比率伤害
		
		public var expPercent:int;//27
		
		public var goldPercent:int//28
		
		public var kill2Hp:int;//29 击杀回血
		
		public var vampire:int //30  吸血
		
		public var attacked2Hp:int;//31 被击中回血
		
		public var beatBack:int; //32 反击
		
		public var damageAddsBounce:int // 33 几率反弹全部伤害
		
		public var defendAddsLess:int //34
		
		public var extraAttack:int;//35
		//测试相关设定
		private var _baseAttribute:int;//基础属性
		
		public function get baseAttribute():int
		{
			return _baseAttribute;
		}
		public function set baseAttribute(value:int):void
		{
			_baseAttribute = value;
			switch(value){
				case 0: //人族
					setDefaultBattleValue(400,100,50,3,1,"*重攻的");
					tezhiVector.push(10,20,30);
					break;
				case 1: //兽族
					setDefaultBattleValue(400,100,50,3,1,"敏捷的");
					tezhiVector.push(20,10,30);
					break;
				case 2: //禽兽
					setDefaultBattleValue(400,100,50,3,1,"*禽兽的");
					tezhiVector.push(20,30,10);
					break;
			}
			dispatchEvent(new Event(SPECIAL_PROPERTY_UPDATE));
		}
		
		private function setDefaultBattleValue(h:uint,m:uint,att:uint,arm:uint,sp:uint,careerName:String):void
		{
			name = careerName + name;
			
			//以下的值会被赋值替代，应该是积累相加关系才对  todo
			hp = h;
			attack = att;
			minDefend = arm ; 
			maxDefend = arm ; 
			speed = sp;
		}
		
		
		public var hasCharacter:Boolean = false;//永远为false，为网络版预留创建人物界面
		
		

	}
}
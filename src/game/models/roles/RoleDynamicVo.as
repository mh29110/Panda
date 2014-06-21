package game.models.roles
{
	import game.controllers.GameEventDispatcher;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.LiveThing;

	/**
	 * 对外提供人物属性，用于ui显示和战斗计算 
	 * 之所以单独提出，是因为使用get的话需要每次都计算装备，技能，属性等因素 
	 * 作为临时值存储 
	 */
	public class RoleDynamicVo extends LiveThing
	{
		public function RoleDynamicVo()
		{
		}
		
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

		override public function get hp():int
		{
			return _hp;
		}

		override public function set hp(value:int):void
		{
			_hp = value;
			if(_hp <= 0){
				_hp = 0;
				GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.LIVE_THING_DEAD,{type:0}));
			}
		}

	}
}
/**
 * 1	生命	 提升生命上限
2	百分比生命	百分比提升生命上限
3	攻击	同时增加最小攻击和最大攻击
4	百分比攻击	百分比同时增加最小攻击和最大攻击
5	最小攻击	增加最小攻击
6	百分比最小攻击	百分比增加最小攻击
7	最大攻击	增加最大攻击
8	百分比最大攻击	百分比增加最大攻击
9	防御	同时增加最小防御和最大防御
10	百分比防御	百分比同时增加最小防御和最大防御
11	最小防御	增加最小防御
12	百分比最小防御	百分比增加最小防御
13	最大防御	增加最大攻击
14	百分比最大防御	百分比增加最大攻击
15	速度	增加速度
16	百分比速度	百分比增加速度
17	暴击	攻击时，几率造成150%伤害
18	暴击伤害	百分比增加暴击后造成的伤害
 * 20???????????
19	暴击伤害减少	百分比减少受到暴击的伤害
21	伤害	百分比增加最终伤害
22	忽视防御	百分比减少对方防御
23	招架	被攻击时，几率减少50%伤害
24	强化招架	百分比增加招架后所减少的伤害
25	伤害减少	百分比减少受到的伤害
26	幸运	提升随机到最大攻击和最大防御的几率
27	反弹伤害	将一定比率受到的伤害反弹给对方
28	贪婪	百分比增加战斗获得的经验
29	积累	百分比增加战斗获得的金币
30	再生	杀敌后恢复自身一定量的生命
31	吸血	每次攻击百分比恢复自身生命
32	血盾	被攻击时，有几率恢复自身6%生命
33	反击	被攻击时，有几率对敌人发动一次攻击
34	刺甲	被攻击时，有几率百分百反弹伤害
35	撕裂	攻击时，有几率造成破甲攻击，忽视对方60%防御
36	连击	有几率造成一次额外的攻击
37	攻击次数	增加每次出手的攻击次数

 **/
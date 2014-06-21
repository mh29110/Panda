package game.models.propertys
{
	/**
	 * 属性配置表 
	 * @author phantom
	 * 
	 */
	public class PropertyConfig
	{
		
		public static const propertyList:Array = ["hp",  //1
			"hpPercent",//2
			"attack",//3
			"attackPercent",//4
			"minAttack",//5
			"minAttackPercent",//6
			"maxAttack",//7
			"maxAttackPercent",//8
			"defend",//9
			"defendPercent",//10
			"minDefend",//11
			"minDefendPercent",//12
			"maxDefend",//13
			"maxDefendPercent",//14
			"speed",//15
			"speedPercent",//16
			"baoji",//17
			"baojiDamage",//18
			"baojiDamageless",//19
			"damagePercent",//20
			"defendlessPercent"//21
		];
		
		public function PropertyConfig()
		{
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
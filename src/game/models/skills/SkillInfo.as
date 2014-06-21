package game.models.skills
{
	public class SkillInfo
	{
		public function SkillInfo()
		{
		}
		public var id:int ;//技能id
		public var sitId:int; //技能类型id
		
		public var sitType:int; //类型
		
		public var name:String; //名称
		
		public var cast:uint;//升级花费
		
		public var explain:String; //说明
		
		public var icon:String = Global.ASSET_FOLDER+"icon.png";
		public var getProb:int ;//获取几率
		
		public var type:int ;//技能类型之2？？ todo
		public var lvl:uint;
		public var canLvl:int ;//需要人物等级
		
		public var prob:int;//技能触发几率
		public var attributeId:int;//触发属性id 
		public var value:int;//触发属性值
		
		
		
		public var hp:int;//1
		public var attack:int;//3
		public var hpPercent:int;//2
		public var attackPercent:int;//4
		public var minAttack:uint;//5
		public var minAttackPercent:int;//6
		public var maxAttack:uint;//7
		public var maxAttackPercent:int;//8
		
		public var defend:int;//9
		public var minDefend:uint;//11
		public var maxDefend:uint;//13
		
		public var defendPercent:int;//10
		public var minDefendPercent:int//12
		public var maxDefendPercent:int//14
		public var speed:int ;//15
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
		
	}
}
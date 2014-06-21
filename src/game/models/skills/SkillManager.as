package game.models.skills
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import game.managers.GameDataConfigManager;
	import game.models.roles.RoleBasicVo;
	import game.models.roles.UserDataProxy;
	
	import utils.CloneByByteArray;
	
	public class SkillManager extends EventDispatcher
	{
		public var propertyAllSkills:RoleBasicVo;//技能所提供的所有属性
		private var _skillBeidong:Vector.<SkillInfo>;
		private const BEIDONG_SKILL_NUM:int = 12;//先做12个技能
		
		public var fightSkills:Vector.<SkillInfo>;//战斗时触发的技能集合
		public static  const  SKILLVO_CHANGE:String = "skill data change ,call player to count property";
		public function SkillManager(target:IEventDispatcher=null)
		{
			super(target);
			_skillBeidong = new Vector.<SkillInfo>(BEIDONG_SKILL_NUM);//固定长度
			propertyAllSkills = new RoleBasicVo();
			fightSkills = new Vector.<SkillInfo>();
			initSkills();
			
			
		}
		
	
		private function initSkills():void
		{
			trace("SkillManager.initSkills():"+ _skillBeidong.fixed + _skillBeidong.length);
			for (var i:int = 0; i < BEIDONG_SKILL_NUM; i++) 
			{
				var skill:SkillInfo = new SkillInfo();//生成一个空的技能描述壳；
				skill = CloneByByteArray.clone( GameDataConfigManager.getInstance().skillsList[i][1] ) as SkillInfo;//此处需要深层复制
				skill.lvl = 0;
				skill.explain = "您还未学习这个技能";
//MD 目前深复制会带入一级的技能属性，会导致0级是一级属性的bug ，所以加一个方法进行置空相关属性，以后技能类型增加时需要扩展
//目前是12个被动 ，貌似主动技能(fightSkills)可以不受这个约束
				clearUpSkill(skill);
				_skillBeidong[i] = skill;
				//如果是战时触发技能，则推入fightSkills中：   coding   需要在战斗时实时计算
				if(skill.type == 2|| skill.type == 3){
					fightSkills.push(skill);
				}
			}
			changeVo();
		}
		
		/**
		 * 深复制会带入一级的技能属性，会导致0级是一级属性的bug ，所以加一个方法进行置空相关属性，以后技能类型增加时需要扩展
		 * 目前完成的是12个技能
		 * @param skill
		 * 
		 */
		private function clearUpSkill(skill:SkillInfo):void
		{
			skill.hp = 0;
			skill.attack = 0;
			skill.defend = 0;
			skill.speed = 0;
			//以上可测，以下待测
			skill.kill2Hp = 0;
			skill.expPercent = 0;
			skill.goldPercent = 0;
			skill.luck = 0;
			//9号技能 毁灭打击 触发
			//10号技能 天神防护 触发
			//11号技能 嗜血 触发
			//12号技能 暴君利刃 触发
		}
		
		public function get skillBeidong():Vector.<SkillInfo>
		{
   			return _skillBeidong;
		}

		public function set skillBeidong(value:Vector.<SkillInfo>):void
		{
			_skillBeidong = value;
			changeVo();
		}
		
		
		private function changeVo():void
		{
			propertyAllSkills = null;
			propertyAllSkills = new RoleBasicVo();//这里也可以换成GoodsDynamic 目前看来数据汇总 GoodsDynamic这个类最合适
			
			
			for each (var item:SkillInfo in _skillBeidong) 
			{
				if(item.type != 1) continue;
//----------------------	
				//第一批实现  已测   后跟属性编号
				propertyAllSkills.hp += item.hp;//1
				propertyAllSkills.attack += item.attack;//3
				propertyAllSkills.minAttack += item.minAttack;//5
				propertyAllSkills.maxAttack += item.maxAttack;//7
				propertyAllSkills.defend += item.defend;//9
				propertyAllSkills.minDefend += item.minDefend;//11
				propertyAllSkills.maxDefend += item.maxDefend;//13
				propertyAllSkills.speed += item.speed;//15
//----------------------	
				//第二批   a,基础属性
				propertyAllSkills.hpPercent += item.hpPercent;//2
				propertyAllSkills.minAttackPercent += item.minAttackPercent;//6
				propertyAllSkills.maxAttackPercent += item.maxAttackPercent;//8
				propertyAllSkills.minDefendPercent += item.minDefendPercent;//12
				propertyAllSkills.maxDefendPercent += item.maxDefendPercent;//14
				propertyAllSkills.speedPercent += item.speedPercent;//16
				propertyAllSkills.baoji += item.baoji;//17
				//		  b,已有技能
				propertyAllSkills.kill2Hp += item.kill2Hp; //29 再生
				propertyAllSkills.expPercent += item.expPercent ; //27 贪婪
				propertyAllSkills.goldPercent += item.goldPercent; //28 积累
				propertyAllSkills.luck += item.luck; //25 
				
				//        c,触发技能 type == 2 ;不会被计算 被推入了fightSkills ，战斗实时计算
				/*propertyAllSkills.attackPercent += item.attackPercent;//4  毁灭打击
				
				propertyAllSkills.defendPercent += item.defendPercent;//10 天神防护
				
				propertyAllSkills.vampire += item.vampire;// 30 嗜血献祭
				
				propertyAllSkills.extraAttack += item.extraAttack;*///35 强化连击
				
//----------------------	
				
			}
			dispatchEvent(new Event(SKILLVO_CHANGE));
		}
		
		/**
		 * 升级指定技能到下一级 
		 * 
		 */
		public function skillUpgrade(oldSkill:SkillInfo):Boolean
		{
			var sit:int = oldSkill.sitId;
			var lvl:int = oldSkill.lvl;
			var pList : * = GameDataConfigManager.getInstance().skillsList[sit-1];
			var newSkill:SkillInfo =CloneByByteArray.clone( GameDataConfigManager.getInstance().skillsList[sit-1][(lvl+1)] ) as SkillInfo;//sit-1 才是xml配表里的
			
			if(!newSkill) return false;//如果取不到技能，则已经是最大级，返回false
			_skillBeidong[sit-1] = newSkill;
			UserDataProxy.getInstance().gold -=  newSkill.cast;
			changeVo();
			return true;
		}
	}
}
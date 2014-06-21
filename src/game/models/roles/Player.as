package game.models.roles
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import game.controllers.GameEventDispatcher;
	import game.controllers.MainController;
	import game.events.EventWithData;
	import game.managers.EquipManager;
	import game.managers.GameDataConfigManager;
	import game.models.skills.SkillManager;
	
	/**
	 * 包含角色数据，显示url相关，一个熊猫角色的整合 
	 * 对外显示完整属性
	 * @author leejia
	 * 
	 */
	public class Player extends EventDispatcher
	{
		protected var _roleBasicVo:RoleBasicVo;// 角色信息
		
		public var index:int = 0;
		
		private var _equipManager:EquipManager;
		
		private var _roleDynamic:RoleDynamicVo;
		
		private var _skillManager:SkillManager;
		
		/***
		 * Player是要写入sharedobject的，推测当从so中读出时会导致不走构造函数。所以使用set／get方法，挂侦听
		 * 如_equipments 在构造函数挂侦听，会没用。
		 * 
		 */
		public function Player( _index:int = 1,target:IEventDispatcher = null )
		{
			super(target);
			index = _index;
			
			//读SO时，全都要重新建立，并且 在line53会重新走一遍构造函数，非常奇怪
			_roleBasicVo = new RoleBasicVo();
			_roleDynamic = new RoleDynamicVo();
			_equipManager = new EquipManager();
			_skillManager = new SkillManager();
			
			//当基础属性变动时
			GameEventDispatcher.getInstance().addEventListener(RoleBasicVo.LEVEL_UPDATE_TO_CHANGE_PROPERTY,onLvlupVoUpdate);
			//当装备改变时
			_equipManager.addEventListener(EquipManager.EQUIPMENT_CHANGE,onEquipUpdate);
			
			//技能管理器处理完升级技能后的数据，汇总player计算总值
			_skillManager.addEventListener(SkillManager.SKILLVO_CHANGE,onSkillDataUpdateHandler);
			
			_roleBasicVo.addEventListener(RoleBasicVo.SPECIAL_PROPERTY_UPDATE,onSpecialPropertyUpdate);
			
		}
		
		/**
		 *  升级技能后的技能数据汇总 
		 * @param event
		 * 
		 */
		protected function onSkillDataUpdateHandler(event:Event):void
		{
			countAllProperty();
		}
		
	
		
		
		/**
		 * 当特质，等级，装备、技能等发生变化时，因为百分比影响，在此进行所有数据汇总重新计算。 
		 * 
		 */
		private function  countAllProperty():void{
			/*1号属性*/	_roleDynamic.hp = roleBasicVo.hp + equipManager.propertyAllequips.hp + skillManager.propertyAllSkills.hp;
			/*附加属性*/	_roleDynamic.hpMax = _roleDynamic.hp;
			
			/*5号属性*/	_roleDynamic.minAttack = roleBasicVo.minAttack + equipManager.propertyAllequips.minAttack + skillManager.propertyAllSkills.minAttack
				+ roleBasicVo.attack + equipManager.propertyAllequips.attack + skillManager.propertyAllSkills.attack;
			
			/*7号属性*/	_roleDynamic.maxAttack = roleBasicVo.maxAttack + equipManager.propertyAllequips.maxAttack + skillManager.propertyAllSkills.maxAttack
				+ roleBasicVo.attack + equipManager.propertyAllequips.attack + skillManager.propertyAllSkills.attack;
			
			/*11号属性*/	_roleDynamic.minDefend = roleBasicVo.minDefend + equipManager.propertyAllequips.minDefend + skillManager.propertyAllSkills.minDefend
				+ roleBasicVo.defend + equipManager.propertyAllequips.defend + skillManager.propertyAllSkills.defend;
			
			/*13号属性*/	_roleDynamic.maxDefend = roleBasicVo.maxDefend + equipManager.propertyAllequips.maxDefend + skillManager.propertyAllSkills.maxDefend
				+ roleBasicVo.defend + equipManager.propertyAllequips.defend + skillManager.propertyAllSkills.defend;
			
			/*15号属性*/	_roleDynamic.speed = roleBasicVo.speed + equipManager.propertyAllequips.speed + skillManager.propertyAllSkills.speed;
			
			
			trace("Player.roleDynamic"+ roleDynamic.hp);
			
			//当以下情况发生时 ， 存档 ：   当特质，等级，装备、技能等发生变化时。
			
			MainController.getInstance().saveSharedObject();
		}
		/**
		 *  当装备改变时 
		 * @param event
		 * 
		 */
		protected function onEquipUpdate(event:Event):void
		{
			//装备的vo在发送事件之前已经改变,见 equipManager.changVo() ，所以这里直接汇总计算 
			countAllProperty();
		}
		
		/**
		 * 当特质变化时回调 
		 * 与 onVoUpdate类似，专为特质属性影响
		 * @param event
		 * 
		 */
		protected function onSpecialPropertyUpdate(event:Event):void
		{
			//改变特质vector的方法 todo   ，也可以已经改变了特质，再到这里。升级是发事件到这里计算，装备是先计算后发事件，都可行
			countAllProperty();
		}
		/**
		 * 升级变化
		 * @param event
		 * 
		 */
		protected function onLvlupVoUpdate(event:EventWithData):void
		{
			//todo 
			levelUpTo(int(event.data));
			
			countAllProperty();
		}
		
		/**
		 * 升级到 lvl级别，基础属性变化 
		 * @param lvl
		 * 
		 */
		public function levelUpTo(lvl:int):void{
			roleBasicVo.hp = GameDataConfigManager.getInstance().rolesProfiles[lvl].hp;
			roleBasicVo.minAttack = GameDataConfigManager.getInstance().rolesProfiles[lvl].minAttack;
			roleBasicVo.maxAttack = GameDataConfigManager.getInstance().rolesProfiles[lvl].maxAttack;
			roleBasicVo.minDefend = GameDataConfigManager.getInstance().rolesProfiles[lvl].minDefend;
			roleBasicVo.maxDefend = GameDataConfigManager.getInstance().rolesProfiles[lvl].maxDefend;
			roleBasicVo.speed = GameDataConfigManager.getInstance().rolesProfiles[lvl].speed;
			
			//特质参数尚未实装，道具表里应该不需要，而是记录在player全局，计算应该在 onVoUpdate()
		}
		
		
		
		
		
		
		public function get roleBasicVo():RoleBasicVo
		{
			return _roleBasicVo;
		}
		
		public function set roleBasicVo(value:RoleBasicVo):void
		{
			_roleBasicVo = value;
			
			//在什么地方转换过一次实例？难道是读取sharedObject？ 总之转换时挂侦听
			if(!_roleBasicVo.hasEventListener(RoleBasicVo.SPECIAL_PROPERTY_UPDATE)){
				_roleBasicVo.addEventListener(RoleBasicVo.SPECIAL_PROPERTY_UPDATE,onSpecialPropertyUpdate);
			}
		}
		
		
		
		public function get roleDynamic():RoleDynamicVo
		{
			return _roleDynamic;
		}
		
		public function set roleDynamic(value:RoleDynamicVo):void
		{
			_roleDynamic = value;
		}
		
		public function get equipManager():EquipManager
		{
			return _equipManager;
		}
		
		public function set equipManager(value:EquipManager):void
		{
			_equipManager = value;
			_equipManager.addEventListener(EquipManager.EQUIPMENT_CHANGE,onEquipUpdate);
		}
		
		public function get skillManager():SkillManager
		{
			return _skillManager;
		}
		
		public function set skillManager(value:SkillManager):void
		{
			_skillManager = value;
			_skillManager.addEventListener(SkillManager.SKILLVO_CHANGE,onSkillDataUpdateHandler);
		}
		
		
		//------------------------------------------------------------------------------------------//
		
		
		//---------------------------------------------------------------//
		
	}
}
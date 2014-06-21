package game.models.guanqia
{
	import flash.events.IEventDispatcher;
	
	import game.controllers.GameEventDispatcher;
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.models.LiveThing;
	
	public class MonsterData extends LiveThing
	{
		public function MonsterData(target:IEventDispatcher = null)
		{
			super(target);
		}
		//怪物的给予经验等级和奖励金币等级
		public var expLvl:int;
		public var goldLvl:int;
		
		
		private var _type:int;//种类
		
		protected var _level:uint;
		
		public function get level():uint
		{
			return _level;
		}
		
		public function set level(value:uint):void
		{
			_level = value;
		}
		
		override public function set hp(value:int):void
		{
			if(value < 0){
				_hp = 0;
				GameEventDispatcher.getInstance().dispatchEvent(new EventWithData(GameEventName.LIVE_THING_DEAD,{type:1}));
				return;
			}
			_hp = value;
		}
		
	}
}
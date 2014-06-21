package game.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class LiveThing extends EventDispatcher
	{
		public var name:String = "";
		
		public var id:int;
		
		public var hpMax:int = 1;
		
		/*  battle value */  //感觉不需要setter/getter  ，这样可以加快运算效率
		protected var _hp:int ;
		
		public function get hp():int
		{
			return _hp;
		}
		
		public function set hp(value:int):void
		{
			_hp = value;
		}
		public var attack:uint;
		
		
		protected var _minAttack:uint;
		public function get minAttack():uint
		{
			return _minAttack;
		}
		
		public function set minAttack(value:uint):void
		{
			_minAttack = value;
		}
		protected var _maxAttack:uint;
		public function get maxAttack():uint
		{
			return _maxAttack;
		}
		
		public function set maxAttack(value:uint):void
		{
			_maxAttack = value;
		}
		
		protected var _minDefend:uint;
		public function get minDefend():uint
		{
			return _minDefend;
		}
		
		public function set minDefend(value:uint):void
		{
			_minDefend = value;
		}
		protected var _maxDefend:uint;
		public function get maxDefend():uint
		{
			return _maxDefend;
		}
		
		public function set maxDefend(value:uint):void
		{
			_maxDefend = value;
		}
		
		protected var _speed:uint;
		public function get speed():uint
		{
			return _speed;
		}
		
		public function set speed(value:uint):void
		{
			_speed = value;
		}
		
		
		public function LiveThing( target:IEventDispatcher = null )
		{
			super( target );
		}
	}
}
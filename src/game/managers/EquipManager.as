package game.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import game.models.goodsVo.GoodsDynamic;

	public class EquipManager extends EventDispatcher
	{
		public static const EQUIPMENT_CHANGE:String="EQUIPMENT_CHANGE"; 
		public var propertyAllequips:GoodsDynamic;
		public function EquipManager(target:IEventDispatcher = null)
		{
			super(target);
			_equipments = new Dictionary();
			propertyAllequips = new GoodsDynamic();
		}
		
		private var _equipments:Dictionary;//装备列表
		
		public function get equipments():Dictionary
		{
			return _equipments;
		}
		
		public function set equipments(value:Dictionary):void
		{
			_equipments = value;
			changeVo();
			dispatchEvent(new Event(EQUIPMENT_CHANGE));
		}
		public function addEquip(type:int ,item:GoodsDynamic):void{
			
			_equipments[type] = item;
			changeVo();
			GoodsListManager.getInstance().removeGoods(item);
			dispatchEvent(new Event(EQUIPMENT_CHANGE));
		}
		public function removeEquip(type:int):GoodsDynamic{
			var goods:GoodsDynamic = _equipments[type];
			delete _equipments[type];
			GoodsListManager.getInstance().addGoods(goods);
			changeVo();
			dispatchEvent(new Event(EQUIPMENT_CHANGE));
			
			return goods;
		}
		
		private function changeVo():void{
			//清空老数据 ， 积累新数值
			propertyAllequips = null;
			propertyAllequips = new GoodsDynamic();
			
			
			for each (var item:GoodsDynamic in _equipments) 
			{
				propertyAllequips.hp += item.hp;
				propertyAllequips.attack += item.attack;
				propertyAllequips.minAttack += item.minAttack;
				propertyAllequips.maxAttack += item.maxAttack;
				propertyAllequips.minDefend += item.minDefend;
				propertyAllequips.maxDefend += item.maxDefend;
				propertyAllequips.defend += item.defend;
				propertyAllequips.speed += item.speed;
				
				//----------------------	
				//第二批   a,基础属性
				propertyAllequips.hpPercent += item.hpPercent;//2
				propertyAllequips.minAttackPercent += item.minAttackPercent;//6
				propertyAllequips.maxAttackPercent += item.maxAttackPercent;//8
				propertyAllequips.minDefendPercent += item.minDefendPercent;//12
				propertyAllequips.maxDefendPercent += item.maxDefendPercent;//14
				propertyAllequips.speedPercent += item.speedPercent;//16
				propertyAllequips.baoji += item.baoji;//17
				//		  b,已有技能
				propertyAllequips.kill2Hp += item.kill2Hp; //29 再生
				propertyAllequips.expPercent += item.expPercent ; //27 贪婪
				propertyAllequips.goldPercent += item.goldPercent; //28 积累
				propertyAllequips.luck += item.luck; //25 
			}
		}
	}
}
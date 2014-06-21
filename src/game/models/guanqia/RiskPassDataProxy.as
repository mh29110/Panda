package game.models.guanqia
{
	import flash.utils.Dictionary;
	
	import game.managers.GameDataConfigManager;
	import game.models.proxys.GameProxy;
	
	/**
	 * 冒险关卡的数据 facade 
	 * 控制刷怪 和 怪物出战
	 * @author leejia
	 * 
	 */
	public class RiskPassDataProxy extends GameProxy
	{
		private static var _instance:RiskPassDataProxy;
		
		public function RiskPassDataProxy()
		{
			super();
			_monsters = new Vector.<Vector.<MonsterData>>();
		}
		public static function getInstance():RiskPassDataProxy{
			return _instance ||= new RiskPassDataProxy();
		}
		
		public function getQuanqiaMonstersByIndex(index:int):Vector.<MonsterData>
		{
			//todo 根据索引获取怪物组
			return guanqiaMonsters(index);
		}
		////////////////////////////////////////////////
		
		//////////////////////////////////////////////////
		
		private var _monsters:Vector.<Vector.<MonsterData>>;
		/**
		 * 根据怪物索引表 ，获取该关卡初始怪物数组 || 根据动态刷怪的策划需求，还需要存储怪物数组到SO ，并每次登录时解析载入
		 * @param index
		 * @return 
		 *  todo
		 */
		public function guanqiaMonsters(index:int):Vector.<MonsterData>
		{
			if(_monsters.length == 0){
				for (var i:int = 0; i < riskConfig.length; i++)//关卡索引 
				{
					_monsters[i] = new Vector.<MonsterData>();// 本关卡怪物数组
					var cIndex:int = riskConfig[i].indexMon;//本关卡配置表 - 怪物索引表 索引
					var dicMonster:Dictionary = GameDataConfigManager.getInstance().indexByMonster[cIndex-1];//-1 获取怪物索引表 配置 
					
					for (var k:int = 0; k < riskConfig[i].max; k++)//本关卡 最大怪物数 
					{
						for each (var obj:Object in dicMonster) //根据怪物索引表里的配置生成怪物
						{
							var prob:Number = Math.random();
							if(prob*100 > obj.prob) continue;
							var m:MonsterData = new MonsterData();
							m = GameDataConfigManager.getInstance().monsters[obj.id];
							_monsters[i].push(m);
						}
					}
				}
			}
			return _monsters[index-1];
		}
		
		public var riskConfig:Vector.<Object>;
		/**
		 * 解析冒险关卡配置文件 
		 * @param value
		 * 
		 */
		public function parseRiskConfig(value:String):void
		{
			var xml:XML = XML(value);		
			riskConfig = new Vector.<Object>(xml.children().length());
			for each (var risk:XML in xml.children()) 
			{
				var obj:Object = {};
				obj.id = int(risk.@id);
				obj.name = risk.name.toString();
				obj.explain = risk.explain.toString();
				obj.canLvl = int(risk.canLvl.toString());
				obj.canGold = int(risk.canGold.toString());
				obj.indexMon = int(risk.indexMon.toString());
				obj.max = int(risk.max.toString());
				riskConfig[obj.id-1] = obj;
			}
		}
	}
}
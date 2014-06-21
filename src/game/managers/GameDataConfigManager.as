package game.managers
{
	import flash.utils.Dictionary;
	
	import game.models.goodsVo.GoodsBasic;
	import game.models.guanqia.MonsterData;
	import game.models.guanqia.RiskPassDataProxy;
	import game.models.propertys.PropertyConfig;
	import game.models.skills.SkillInfo;
	
	import morn.core.handlers.Handler;

	public class GameDataConfigManager
	{
		//以下均使用dictionary，因为id做索引有可能直接是20001，这样用数组就太可笑了
		public var goodsList:Dictionary;
		/**
		 * 技能配置表 
		 */
		public var skillsList:Dictionary;
		/**
		 * 人物属性配置表   
		 */
		public var rolesProfiles:Vector.<Object>;
		
		/**
		 * 怪物配置表 
		 */
		public var monsters:Dictionary;
		/**
		 * 怪物索引表  
		 */
		public var indexByMonster:Vector.<Dictionary>;
		
		/**
		 * 物品随机属性索引表 
		 */
		public var goodsPropertyIndex:Vector.<Dictionary>;
		public function GameDataConfigManager()
		{
			goodsList = new Dictionary();
			skillsList = new Dictionary();
			monsters = new Dictionary();
			
			rolesProfiles = new Vector.<Object>(60);//fix
		}
		
		private var parseCompleteFunc:Function;
		public function startLoadConfig(parseComplete:Function):void{
			App.loader.loadTXT("assets/configs/goods.xml",new Handler(parseGoodsXML),null,null,false);//加载后不缓存
			App.loader.loadTXT("assets/configs/roles.xml",new Handler(parseRolesXML),null,null,false);//加载后不缓存
			App.loader.loadTXT("assets/configs/skills.xml",new Handler(parseSkillsXML),null,null,false);//加载后不缓存
			App.loader.loadTXT("assets/configs/IndexByMonster.xml",new Handler(parseIndexMonsterXML),null,null,false);//加载后不缓存
			App.loader.loadTXT("assets/configs/risk.xml",new Handler(parseRiskConfigXML),null,null,false);//加载后不缓存
			App.loader.loadTXT("assets/configs/goodsPropertyIndex.xml",new Handler(parseGoodsPropertyIndexConfigXML),null,null,false);//加载后不缓存
			
			
			
			//这个资源压轴，因为全部加载解析完毕的回调在这里
			parseCompleteFunc = parseComplete;
			App.loader.loadTXT("assets/configs/monsters.xml",new Handler(parseMonstersXml),null,null,false);//加载后不缓存
		}
		
		private function parseGoodsPropertyIndexConfigXML(value:String):void
		{
			var xml:XML = XML(value);
			
			goodsPropertyIndex = new Vector.<Dictionary>(xml.children().length());
			for each (var node:XML in xml.children()) 
			{
				goodsPropertyIndex[node.@id-1] = new Dictionary();
				for each (var prop:XML in node.children()) 
				{	
					var property:Object = {};
					property.id = int(prop.@id.toString());
					property.value = int(prop.value.toString());
					property.prob = int(prop.prob.toString());
					goodsPropertyIndex[node.@id-1][property.id] = property;
				}
			}
			trace("GameDataConfigManager.parseGoodsPropertyIndexConfigXML(value)"+goodsPropertyIndex);
		}
		
		/**
		 * 解析risk冒险关卡配置文件 
		 * 
		 */
		private function parseRiskConfigXML(value:String):void
		{
			RiskPassDataProxy.getInstance().parseRiskConfig(value);			
		}
		
		/**
		 * 怪物索引表 
		 * 
		 */
		private function parseIndexMonsterXML(value:String):void
		{
			var xml:XML = XML(value);
			indexByMonster = new Vector.<Dictionary>(xml.children().length());//fix
			for each (var indexMon:XML in xml.children()) 
			{
				indexByMonster[int(indexMon.@id)-1] = new Dictionary();
				for each (var mon:XML in indexMon.children()) 
				{
					var obj:Object = {};
					obj.id = int(mon.@id);
					obj.prob = int(mon.toString());
					indexByMonster[int(indexMon.@id-1)][obj.id] = obj;
				}
			}
			trace("GameDataConfigManager.parseIndexMonsterXML(value)"+indexByMonster);
		}
		
		/**
		 * 解析怪物表 
		 * 
		 */
		private function parseMonstersXml(value:String):void
		{
			var xml:XML = XML(value);
			for each (var monster:XML in xml.children()) 
			{
				var m:MonsterData = new MonsterData();
				m.id = int(monster.@id);
				m.level = int(monster.level);
				m.speed = int(monster.speed);
				m.minAttack = int(monster.minAttack);
				m.maxAttack = int(monster.maxAttack);
				m.minDefend = int(monster.minDefend);
				m.maxDefend = int(monster.maxDefend);
				m.hp = int(monster.hp);
				m.hpMax = int(monster.hp);
				m.expLvl = int(monster.expLvl);
				m.goldLvl = int(monster.goldLvl);
				m.name = monster.name.toString();
				
				monsters[m.id] = m;
				
			}
			parseCompleteFunc();
		}
		
		private function parseSkillsXML(value:String):void
		{
			var xml:XML = XML(value);
			for (var i:int = 0; i < 15; i++) 
			{
				skillsList[i] = new Dictionary();
				for each (var item:XML in xml.skill.(sitId == (i+1))) 
				{
					var obj:SkillInfo = new SkillInfo();
					obj.id = int(item.indexId);//技能id
					obj.sitId = int(item.sitId);
					obj.sitType = int(item.sitType);
					obj.getProb = Number(item.getProb);
					
					obj.name = item.name.toString();
					obj.icon = Global.ASSET_FOLDER+ "icon"+ int(item.picId) +".png";
					
					obj.type = int(item.type);
					obj.lvl = int(item.level);//技能等级
					
					obj.explain = item.explain.toString();//描述
					obj.canLvl = int(item.canLvl);
					obj.cast = int(item.cast);
					
					obj.prob = Number(item.prob);
					obj.attributeId = int(item.attributeId);
					obj.value = Number(item.value);
				
					skillsList[i][int(item.level)] = obj;
					
					if(obj.attributeId > PropertyConfig.propertyList.length ) continue;
					switch(obj.type) {//举例根据属性id来获取属性   属性索引表
						case 1://基础属性
							obj[  PropertyConfig.propertyList[obj.attributeId-1]  ] = obj.value;
							break;
						case 2://攻击时触发
							obj[  PropertyConfig.propertyList[obj.attributeId-1]  ] = obj.value;
							break;
						case 3://被攻击时触发
							break;
					}
				}
			}
			trace("GameDataConfigManager.parseSkillsXML(value)"+skillsList);
		}
		
		/**
		 * 解析人物属性配置表 
		 * 
		 */
		private function parseRolesXML(value:String):void
		{
			var xml:XML = XML(value);
			for each (var item:XML in xml.children()) 
			{
				var obj:Object = {};
				obj.level = int(item.@value);
				obj.speed = int(item.speed);
				obj.exp = int(item.exp);
				obj.minAttack = int(item.minAttack);
				obj.maxAttack = int(item.maxAttack);
				obj.minDefend = int(item.minDefend);
				obj.maxDefend = int(item.maxDefend);
				obj.hp = int(item.hp);
				rolesProfiles[obj.level] = obj;
			}
			trace("GameDataConfigManager   rolesProfiles:"+rolesProfiles);
			
		}
		
		/**
		 * 解析物品文件 
		 * 
		 */
		private function parseGoodsXML(value:String):void
		{
			var xml:XML = XML(value);
			for each ( var e:XML in xml.children())
			{
				var good:GoodsBasic = new GoodsBasic();
				good.id = e.@id.toString();
				good.name = e.name.toString();
				good.icon = Global.ASSET_FOLDER+"item"+e.picId.toString()+".png";
				good.type = e.type.toString();
				good.canLvl = e.canLvl.toString();
				good.hp = e.hp.toString();
				good.speed = e.speed.toString();
				
				good.minAttack = e.minAttack.toString();
				good.maxAttack = e.maxAttack.toString();
				
				good.minDefend = e.minDefend.toString();
				good.maxDefend = e.maxDefend.toString();
				
				good.randomAttributeId1 = e.randomAttributeId1.toString();
				good.prob1 = Number(e.prob1.toString());
				good.randomAttributeId2 = e.randomAttributeId2.toString();
				good.prob2 = Number(e.prob2.toString());
				good.randomAttributeId3 = e.randomAttributeId3.toString();
				good.prob3 = Number(e.prob3.toString());
				good.randomAttributeId4 = e.randomAttributeId4.toString();
				good.prob4 = Number(e.prob4.toString());
				
				good.sale = int(e.sale);
				
				goodsList[e.@id.toString()] = good;
				
			}
			trace("GameDataConfigManager.parseGoodsXML(value)"+goodsList);
			
		}		
		
		private static var _instance:GameDataConfigManager;
		public static function getInstance():GameDataConfigManager
		{
			return _instance ||= new GameDataConfigManager();
		}
	}
}
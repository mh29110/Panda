package game.models.goodsVo
{
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	import game.managers.GameDataConfigManager;
	import game.models.propertys.PropertyConfig;

	public class RetrieveGoodsUtils
	{
		public function RetrieveGoodsUtils()
		{
		}
		private static const RANDOM_BASE:int = 10000;
		private static var dynamicID:int = 0;//转换来的物品id
		/**
		 * 根据 goodsBasic id 检索返回 动态生成的GoodsDynamic 
		 * @return 
		 * 
		 */
		public static function GoodsBasic2Dynamic( index:int ):GoodsDynamic
		{
			var _localSharedObject:SharedObject = SharedObject.getLocal("localCache");
			if( _localSharedObject.data["dynamicID"] != 0){
				dynamicID = _localSharedObject.data["dynamicID"];
			}
			dynamicID++;
			_localSharedObject.data["dynamicID"] = dynamicID;
			
			
			var basic:GoodsBasic = GameDataConfigManager.getInstance().goodsList[index];
			var dynamic:GoodsDynamic = new GoodsDynamic();
			dynamic.id = dynamicID; 
			dynamic.name = basic.name;
			dynamic.canLvl = basic.canLvl;
			dynamic.color = basic.color;
			dynamic.explain = basic.explain;
			dynamic.hp = basic.hp;
			dynamic.icon = basic.icon;
			dynamic.maxAttack = basic.maxAttack;
			dynamic.maxDefend = basic.maxDefend;
			dynamic.minAttack = basic.minAttack;
			dynamic.minDefend = basic.minDefend;
			dynamic.speed = basic.speed;
			
			dynamic.sale = basic.sale;
			dynamic.type = basic.type;
			dynamic.subtype = 1;//永远为1，可装备类型
			
//			dynamic[属性索引得到属性名] ＝ basic . prob该道具的属性的取值范围 
			
			//coding  先做属性索引表解析 ，再做随机动态填充
			
			//考虑用一个dic 来存储需要标识的动态属性   用equipManager先一步汇总出字典中的信息到equipAllproperty.     然后去player汇总
			
			var indexList :Vector.<Dictionary> = GameDataConfigManager.getInstance().goodsPropertyIndex;//物品随机属性索引表
			
			//随机属性1
			if(Math.random() < basic.prob1){
				var dic:Dictionary = indexList[basic.randomAttributeId1-1];
				for each (var obj:Object in dic) 
				{
//					trace(PropertyConfig.propertyList[ dic[obj.id].id - 1]);
					dynamic[ PropertyConfig.propertyList[ dic[obj.id].id - 1] ] +=	dic[obj.id].value;
				}
				
			}
			// coding  暂时不做属性随机几率，直接都100%获得，方便测试
			//随机属性2
			if(Math.random() < basic.prob2/RANDOM_BASE){
				var dic2:Dictionary = indexList[basic.randomAttributeId2-1];
				for each (var obj2:Object in dic2) 
				{
//					trace(PropertyConfig.propertyList[ dic2[obj2.id].id - 1]);
					dynamic[ PropertyConfig.propertyList[ dic2[obj2.id].id - 1] ] =	dic2[obj2.id].value;
					dynamic.randomFlag.push( obj2.id );
				}
				
			}
			//随机属性3
			if(Math.random() < basic.prob3/RANDOM_BASE){
				var dic3:Dictionary = indexList[basic.randomAttributeId3-1];
				for each (var obj3:Object in dic3) 
				{
					dynamic[ PropertyConfig.propertyList[ dic3[obj3.id].id - 1] ] =	dic3[obj3.id].value;
					dynamic.randomFlag.push( obj3.id );
				}
			}
			//随机属性4
			if(Math.random() < basic.prob4/RANDOM_BASE){
				var dic4:Dictionary = indexList[basic.randomAttributeId4-1];
				for each (var obj4:Object in dic4) 
				{
					dynamic[ PropertyConfig.propertyList[ dic4[obj4.id].id - 1] ] =	dic4[obj4.id].value;
					dynamic.randomFlag.push( obj4.id );
				}
			}
			
			
			return dynamic;
		}
	}
}
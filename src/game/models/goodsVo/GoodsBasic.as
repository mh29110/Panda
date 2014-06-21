package game.models.goodsVo
{
	public class GoodsBasic
	{
		public function GoodsBasic()
		{
		}
		public var id:int;
		public var name:String; //名称
		public var type:int; //类型
		public var color:int; //颜色
		public var explain:String; //说明
		
		public var icon:String = Global.ASSET_FOLDER+"icon.png";
		
		///////******     dynamic       ****///////////
		public var speed:int ;
		//todo
		public var canLvl:int ;//装备等级
		public var hp:int;
		
		public var minAttack:uint;
		public var maxAttack:uint;
		public var minDefend:uint;
		public var maxDefend:uint;
		
		public var randomAttributeId1:int;
		public var prob1:Number;
		public var randomAttributeId2:int;
		public var prob2:Number;
		public var randomAttributeId3:int;
		public var prob3:Number;
		public var randomAttributeId4:int;
		public var prob4:Number;
		
		public var sale:int;//售价
	}
}
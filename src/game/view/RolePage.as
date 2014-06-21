package game.view
{
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.utils.getQualifiedClassName;
	
	import game.managers.GoodsListManager;
	import game.models.goodsVo.GoodsDynamic;
	import game.models.roles.Player;
	import game.models.roles.UserDataProxy;
	import game.models.roles.bag.BagConfig;
	import game.models.roles.bag.BagGrid;
	import game.ui.roleUI.RolePageUI;
	import game.view.dialogs.GoodsInfoDialog;
	
	import morn.core.components.Clip;
	import morn.core.components.Component;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	
	/**
	 *人物属性+ 背包界面  
	 * @author leejia
	 * 
	 */
	public class RolePage extends RolePageUI
	{
		public function RolePage()
		{
			super();
			configUI();
			initListeners();
			
			//item 增加鼠标划过效果 ，使用 clip_selectedBox  参考 http://blog.mornui.com/?p=365 || 手游不需要这个
		}
		
		private function configUI():void
		{
			bagGoodsList.renderHandler = new Handler(listRender);
		}
		/**自定义List项渲染*/
		private function listRender(item:Component, index:int):void {
			
			if (index < bagGoodsList.length) {
				var selectClip:Clip = item.getChildByName("selectBox") as Clip;
				if( bagGoodsList.array[index].type == 2)
				{
					selectClip.visible = false;
				}
				var label:Label = item.getChildByName("label") as Label;
				label.visible = false;
			}
		}
		/**
		 * 刷新装备显示 
		 * 
		 */
		public function refreshEquipments():void
		{
			var player:Player = UserDataProxy.getInstance()["user_"+(currentHero+1)];
			for (var i:int = 1; i < 8; i++) 
			{
				this["equip_"+i].dataSource = {url:""};
			}
			
			for each (var good:GoodsDynamic in player.equipManager.equipments) 
			{
				this["equip_"+good.type].dataSource = {url:good.icon,data:good};
			}
			
			showRoleFightValue(player);
		}
		
		/**
		 * 刷新人物属性栏 
		 * 
		 */
		private function showRoleFightValue(player:Player):void
		{
			heroName.text = player.roleBasicVo.name ;
			
			hp.text = "" + player.roleDynamic.hp + "/" + player.roleDynamic.hpMax;
			attack.text = "" /*+ player.roleDynamic.attack+"/"*/ + player.roleDynamic.minAttack+"/" + player.roleDynamic.maxAttack;
			defend.text = "" /*+ player.roleDynamic.defend+"/" */+ player.roleDynamic.minDefend+"/" + player.roleDynamic.maxDefend;
			speed.text = "" + player.roleDynamic.speed;
			defendPercent.text = "1:" + player.roleBasicVo.tezhiVector[0];
			attackPercent.text = "2:" + player.roleBasicVo.tezhiVector[1]
				+ ":::3:" + player.roleBasicVo.tezhiVector[2];
		}		
		
		private function initListeners():void
		{
			//bag
			bagGoodsList.selectHandler = new Handler(onGoodSelectorHandler);
			nextPageBtn.clickHandler = new Handler(onNextPageHandler);
			backPageBtn.clickHandler = new Handler(onTurnbackPageHandler);
			//hero
			heroSelectTab.selectHandler = new Handler(onChangeHeroHandler);
			
			//equip
			for (var i:int = 1; i < 8; i++) 
			{
				this["equip_"+i].addEventListener(MouseEvent.CLICK,onEquipClick);	
			}
			
			//ui _close
			close.clickHandler = new Handler(onCloseUIHandler);
		}
		
		private function onCloseUIHandler():void
		{
			Global.gameStage.removeChild(this);
		}		
		
		
		private function onEquipClick(event:MouseEvent):void{
			if(!event.target.dataSource) return;
			var good:GoodsDynamic = event.target.dataSource.data;
			GoodsInfoDialog.instance.pushData(1,{heroIndex:currentHero,data:good});
			GoodsInfoDialog.instance.popup();
		}
		/**
		 * 背包项选择器 
		 * 
		 */
		private function onGoodSelectorHandler(index:int):void
		{
			
			if(index == -1) return; //使能重复选择，当关闭物品信息后设置selectedIndex 为-1；
			
			switch(bagGoodsList.selectedItem.type)
			{
				case 1://点击物品
					GoodsInfoDialog.instance.pushData(2,{heroIndex:currentHero,data:bagGoodsList.selectedItem.data},cancelSelect);
					GoodsInfoDialog.instance.show();
					break;
				case 2://点击空白
					break;
				case 3://点击lock  todo
					if(UserDataProxy.getInstance().gold < 1000) 
					{
						trace("买不起背包");
						return ;
					}
					UserDataProxy.getInstance().gold -= 1000;
					UserDataProxy.getInstance().bagGridNum += 10;
					refreshBagData();
					cancelSelect();
					trace("开锁");
					// 注意传入cancelSelect，作为新对话框关闭的回调函数。否则关闭后当前按钮无法再次被选择
					break;
					
			}
			
			function cancelSelect():void{
				bagGoodsList.selectedIndex = -1;
			}
			
			/*
			* ........  push用加好会分n次执行函数，所以会断点n次，有意思的发现
			*/
			//断点之后触发4次？？？debug  ***
			//GoodsInfoDialog.instance.pushData(2,{heroIndex:currentHero,data:bagGoodsList.selectedItem.data},cancelSelect);
		}
		
		private var currentHero:uint = 0;
		/**
		 * 选择英雄 
		 * 
		 */
		private function onChangeHeroHandler(index:int):void
		{
			currentHero = index;
			heroImg.transform.colorTransform = new ColorTransform(Math.random(),Math.random(),Math.random());
			refreshEquipments();
		}
		private var currentPage:int = 0;
		/**
		 *  换页按钮 ++  
		 * 
		 */
		private function onNextPageHandler():void
		{
			if( bagGoodsList.page == bagGoodsList.totalPage-1) //已经最大页 
			{	return;	}
			bagGoodsList.page ++;
		//	pageBtn.label = "第" + bagGoodsList.page +"页";
			
			/*currentPage++;
			bagGoodsList.page = (bagGoodsList.page == bagGoodsList.totalPage-1) ? 0 : currentPage ;
			if(bagGoodsList.page == bagGoodsList.totalPage-1)  
				currentPage = -1;
			trace(bagGoodsList.page);
				pageBtn.label = "第" + bagGoodsList.page +"页";*/
		}
		private function onTurnbackPageHandler():void
		{
			if( bagGoodsList.page == 0) //已经最大页 
			{	return;	}
			bagGoodsList.page --;
		}
		
	
		/**
		 * bagView 实为list组件 
		 * 
		 */
		public function refreshBagData():void
		{
			var goods:Vector.<GoodsDynamic> = GoodsListManager.getInstance().goods;
			//清空数据
			var provider:Array = [];
			//type 1 ，添加物品列表
			var len:int = goods.length; 
			for (var i:int = 0; i < len; i++) //先把物品数据移动到bag中
			{
				var realGoods:Object = {};
				realGoods.type = 1;
				realGoods.data = goods[i];
				realGoods.icon = goods[i].icon;
				provider.push(realGoods);
			}
			//type 2,空白
			var currentBagMax:uint = UserDataProxy.getInstance().bagGridNum;//已经购买的格子数上限
			for (var j:int = len; j < currentBagMax; j++) 
			{
				var nullGoods:Object = new Object();
				nullGoods.type = 2;
				nullGoods.data = null;
				nullGoods.icon = "";
				provider.push(nullGoods);
			}
			//type 3 ,lock
			var bgn:int = UserDataProxy.getInstance().bagGridNum;
			var less2Max:int =  (bagGoodsList.repeatX*bagGoodsList.repeatY) - ( bgn % (bagGoodsList.repeatX*bagGoodsList.repeatY) );
			for (var k:int = 0; k < less2Max; k++) 
			{
				var lock:Object = new Object();
				lock.type = 3;
				lock.icon = Global.ASSET_FOLDER+"lockIcon.png";
				provider.push( lock	);
			}
			
			bagGoodsList.dataSource = provider;
			
			//初级版本，只有物品
			/*var goodsArr:Array = [ ];
			
			var len:int = goods.length;
			for (var i:int = 0; i < len; i++) 
			{
			goodsArr[i] = {icon:goods[i].icon,data:goods[i]};	
			}
			
			bagGoodsList.array  = goodsArr;*/
		}
		
		/**
		 * 释放侦听和内存 
		 * 
		 */
		private function dispose():void
		{
			
		}
	}
}
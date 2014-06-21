package game.controllers
{
	import flash.events.Event;
	
	import game.events.EventWithData;
	import game.events.GameEventName;
	import game.managers.GoodsListManager;
	import game.models.goodsVo.RetrieveGoodsUtils;
	import game.models.roles.UserDataProxy;
	import game.view.MainPage;
	import game.view.SweepStakeView;
	
	import morn.core.handlers.Handler;

	public class SweepStakeController extends Controller
	{
		/**
		 * 当前奖品池 
		 */
		private var cPrize:Array;
		public function SweepStakeController()
		{
			super();
			initData();
			initListeners();
		}
		
		private function initData():void
		{
			cPrize = [];			
		}
		
		private function initListeners():void
		{
			dispatcher.addEventListener(GameEventName.SHOW_SWEEPSTAKE_VIEW,popUp);	
			sweepStakeView.addEventListener(SweepStakeView.COMMIT_TO_DRAW,onCommitHandler);
		}		
		
		protected function onCommitHandler(event:Event):void
		{
			
			//做 动画，完毕后执行以下数据处理，并提示
			
			if(UserDataProxy.getInstance().gold < UserDataProxy.getInstance().level * UserDataProxy.getInstance().level) {
				trace("金币不够");				
				return ;//钱不够
			}
			
			refreshSweepData();	//刷新奖品区
			
			UserDataProxy.getInstance().gold -= UserDataProxy.getInstance().level * UserDataProxy.getInstance().level;
			
			for (var i:int = 0; i < cPrize.length; i++) 
			{
				GoodsListManager.getInstance().addGoods( cPrize[i]);
			}
			cPrize = [];
			trace("抽奖成功，请去背包查看，多了20件物品。。。你牛B了");
		}		
		
		private function popUp(event:EventWithData):void{
			//添加view
			sweepStakeView.popup();
		}
		
		/**
		 * 根据 玩家等级来确定奖品   todo
		 * 
		 */
		public function refreshSweepData():void
		{
			//根据配置表  和 玩家等级 来索引奖品
			cPrize = [];
			for (var i:int = 0; i < 20; i++) 
			{
				//这里可以做一个switch来随机生成奖品、经验、金币，也可以读配置表
				cPrize.push(RetrieveGoodsUtils.GoodsBasic2Dynamic(Math.random()*8+1));
			}
		}
		private var _view:SweepStakeView;
		public function get sweepStakeView():SweepStakeView
		{
			if(!_view)
			{
				_view = new SweepStakeView();
			}
			return _view;
		}
		
		public function set sweepStakeView(value:SweepStakeView):void
		{
			_view = value;
		}
		
		
		private static var _instance:SweepStakeController;
		public static function getInstance():SweepStakeController{
			return _instance ||= new SweepStakeController();
		}
	}
}
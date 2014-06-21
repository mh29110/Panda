package game.view
{
	import game.models.roles.UserDataProxy;
	import game.ui.roleUI.TopUserInfoViewUI;
	
	public class TopUserInfoView extends TopUserInfoViewUI
	{
		public function TopUserInfoView()
		{
			super();
			goldText.text = "" + UserDataProxy.getInstance().gold;
			expText.text = "" + UserDataProxy.getInstance().exp;
			levelText.text = "" + UserDataProxy.getInstance().level;
		}
	}
}
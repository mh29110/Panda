MornUI issue :
     如果在UI中使用了原图尺寸很大的image，则会对内存有极大的占用，需要使用mornUI（image双击）压缩。对于欢迎界面等不常用的UI资源，应该及时进行释放！
     AssetManager 提供了各种释放资源的方法，可以在界面销毁的时候释放掉。但是不知道如果重新需要的话，会不会重新建立

	App.asset.disposeBitmapData("jpg.map.map1");
	assetManager手动释放位图数据后，动态加载
	
	1: 首先压缩资源
	2：手动释放资源，需要时动态加载。
	
	

LoaderManager.as 156行  原作者遗漏了return. 
package{
	import flash.display.Sprite;
	import flash.net.URLStream;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import flash.text.TextField;
	
	public class ImageProLoad extends Sprite{
		//define all the properties
		private var loader:Loader;
		private var imageStream:URLStream;
		private var imageData:ByteArray;
		
		private var tf:TextField;
		
		//constructor
		public function ImageProLoad():void{
			 tf = new TextField();
			 this.addChild(tf);
			 tf.width = 500;
			 tf.selectable = false;
                   init();
			 loadImage("http://www.ezrabessaroth.net/images/oldinterioreb.bmp");
			}
			
		private function init():void{
			loader = new Loader();
			this.addChild(loader);
			loader.cacheAsBitmap = true;
			imageStream = new URLStream();
			imageStream.addEventListener(ProgressEvent.PROGRESS,imageStreamProgress);
			imageStream.addEventListener(Event.COMPLETE,imageStreamComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,displayImage);
			}
			
		private function imageStreamProgress(event:ProgressEvent):void{
			//if there are no bytes load, do nothing
			if (imageStream.bytesAvailable == 0) return;
			//process the data
			processImageData();
			}
			
		private function imageStreamComplete(event:Event):void{
			//check if connection there, stop it
			if (imageStream.connected){
				imageStream.close();
				}
			}
		
		private function processImageData():void{
			//if connnected, read all the bytes in the byteArray;
			if (imageStream.connected){
				imageStream.readBytes(imageData,imageData.length);
				}
				tf.text = "Bytes Loading: " + imageData.bytesAvailable;
			//clean all the data in the loader
			loader.unload();
			//push the aggregate byteArray data in the loader
			loader.loadBytes(imageData);
			}
		
		//function to loading the image
		private function loadImage(addr:String):void{
			//check if the connection there, then stop it
			//for a new connection to be step up;
			if (imageStream.connected){
				imageStream.close();
				}
			//load a new image url
			imageStream.load(new URLRequest(addr+'?'+getTimer()));
			//clean the loader
			loader.unload();
			//create a new byteArray to store the aggregate data
			imageData = new ByteArray();
			}
		
		//function to display the image
		private function displayImage(event:ProgressEvent):void{
			}
		}//end of the class
	}//end of the package
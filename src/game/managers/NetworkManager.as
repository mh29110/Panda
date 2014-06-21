package game.managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import game.network.SocketPacket;
	
	public class NetworkManager extends EventDispatcher
	{
		private var _socket:Socket;
		public function NetworkManager(target:IEventDispatcher=null)
		{
			super(target);
			initSocket();
		}
		
		public function sendMessage(type:int , words:String, playerId:int = -1):void
		{
			_socket.writeUnsignedInt(type);
			_socket.writeInt(playerId);
			_socket.writeUTFBytes(words);
			_socket.flush();
		}
			
		private static var _instance:NetworkManager;
		public static function getInstance():NetworkManager
		{
			return _instance ||= new NetworkManager();
		}	
		private function initSocket():void
		{
			_socket = new Socket();
			_socket.connect("192.168.1.104",6881);
			_socket.addEventListener(Event.CONNECT,onConnectedHandler);
			_socket.addEventListener(Event.CLOSE,onCloseHandler);
			_socket.addEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityErrorHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA,onReceiveDataHandler);
		}		
		
		protected function onReceiveDataHandler(event:ProgressEvent):void
		{
			trace("NetworkManager.onReceiveDataHandler(event)");
			
		}
		
		protected function onSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace("NetworkManager.onSecurityErrorHandler(event)");
		}
		
		protected function onIOErrorHandler(event:IOErrorEvent):void
		{
			// TODO Auto-generated method stub
			trace("NetworkManager.onIOErrorHandler(event)",event.text);
		}
		
		protected function onConnectedHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("NetworkManager.onConnectedHandler(event)");
		}
		
		protected function onCloseHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("NetworkManager.onCloseHandler(event)");
		}		

	}
}
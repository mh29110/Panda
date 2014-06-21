package game.events
{
	import flash.events.Event;
	
	public class EventWithData extends Event
	{
		public var data:Object=null;
		
		public function EventWithData(type:String,$data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			if($data){
				this.data = $data;
			}
		}
		
		override public function clone():Event {
			return new EventWithData(type, data, bubbles, cancelable);
		}
	}
}
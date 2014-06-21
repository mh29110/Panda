package utils
{
	import flash.utils.ByteArray;
	
	public class CloneByByteArray
	{
		public function CloneByByteArray()
		{
		}
		public static function clone(target:Object):Object
		{
			var copy:ByteArray = new ByteArray();
			copy.writeObject(target);
			copy.position = 0;
			return copy.readObject();
		}
	}
}
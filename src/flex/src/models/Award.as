package models
{	
	[RemoteClass(alias="Award")]
	public class Award
	{
		public var _id:int;
		public var name:String;
		

		public function Award()
		{
			//TODO: implement function
		}
		
		public function toString():String
		{
			return this.name;
		}
	}
}
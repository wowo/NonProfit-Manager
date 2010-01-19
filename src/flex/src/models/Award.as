package models
{
	[RemoteClass(alias="models.Member")]	
	import mx.core.Application;
	import mx.events.FlexEvent;
	import mx.rpc.events.ResultEvent;
	public class Award
	{
		public var id:int;
		public var name:String;
		public var descriptioon:String;
		public var createdAt:Date;
		public var updatedAt:Date;

		public function Award()
		{
			//TODO: implement function
		}
		
		public function toString():String
		{
			return this.name;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public static function getAllItemsResultHandler(event:ResultEvent):void
		{
			Application.application.awardGrid.dataProvider = event.result;
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public static function gridInitialize(event:FlexEvent):void
		{
			Application.application.awardsRO.getAllItems();
		}
	}
}
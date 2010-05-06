package controllers
{
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;
	import mx.utils.URLUtil;
	
	/**
	 * Main controller and also base controller for any others. 
	 * 
	 * @author wowo
	 */
	public class Controller
	{
		/**
		 * Reference to application 
		 */
		protected var app:Object;
		
		/**
		 * The constructor. It take app reference as parameter.
		 *  
		 * @param app
		 */		
		public function Controller(app:Application)
		{
			this.app = app;
		}
		
		/**
		 * Initialize application - sets endpoints for remote objects
		 *  
		 * @param event
		 */
		public static function applicationInitialize(event:FlexEvent):void
		{
			var remoteObjects:Array = new Array(
				Application.application.memberRO, 
				Application.application.awardsRO
			);
			for (var i:int; i < remoteObjects.length; i++) {
				remoteObjects[i].endpoint = Controller.getEndpointUrl() +  '/gateway/';
				//Alert.show(remoteObjects[i].endpoint);
			}
		}
		
		/**
		 * Handles grid item change.
		 *  
		 * @param event
		 */
		public function gridChangeHandler(event:ListEvent):void
		{
			this.app.selectedItem = event.target.selectedItem;
		}
		
		/**
		 * Gets endpoint url
		 *  
		 * @return endpoint url 
		 */
		private static function getEndpointUrl():String
		{
			var endpoint:String = 'http://';
			if (Application.application.url.indexOf("file://") == 0) {
				endpoint += '127.0.0.1:8000';
			} else {
				endpoint += URLUtil.getServerNameWithPort(Application.application.url);
			}
			return endpoint;
		}
		
		/**
		 * Generic method to display AMF fault message.
		 * It shows the message in Alert box.
		 * 
		 * @param message
		 */
		public static function fault(message:String):void
		{
			Alert.show(message, "Wystąpił błąd krytyczny");
		}
	}
}
package controllers
{
	import mx.controls.Alert;
	import mx.core.Application;
	
	public class Controller
	{
		protected var app:Object;
		
		public function Controller(app:Application)
		{
			this.app = app;
		}
		
		public static function fault(message:String):void
		{
			Alert.show(message, "Wystąpił błąd krytyczny");
		}
	}
}
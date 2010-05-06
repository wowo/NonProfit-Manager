package controllers
{
	import mx.core.Application;
	import mx.events.FlexEvent;
	import mx.rpc.events.ResultEvent;

	public class AwardsController extends Controller
	{
		public function AwardsController(app:Application)
		{
			super(app);
		}
		
		public function getAllResultHandler(event:ResultEvent):void
		{
			this.app.awardGrid.dataProvider = event.result;
		}
		

		public function gridInitialize(event:FlexEvent):void
		{
			this.app.awardsRO.getAll();
		}
	}
}
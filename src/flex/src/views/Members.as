package views
{
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import models.Member;
	
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.Application;


	/**
	 * 
	 * @author wowo
	 * 
	 */
	public class Members
	{
		/**
		 * 
		 * 
		 */
		public function Members()
		{
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */
		public static function	saveMember(event:MouseEvent):void
		{
			var newMember:Member = new Member();
			newMember.id = 0;
			newMember.name = Application.application.memberForm.nameInput.text;
			newMember.surname = Application.application.memberForm.surnameInput.text;
			newMember.fatherName = Application.application.memberForm.fatherNameInput.text;
			Application.application.membersRO.save(newMember);
		}
		
		/**
		 * Generates PDF report in new browser window (probably download it)
		 * @param event
		 * 
		 */
		public static function generateReport(event:MouseEvent):void
		{
			var columns:Array = new Array();
			for (var i in Application.application.grid.columns) {
				var col:DataGridColumn = Application.application.grid.columns[i] as DataGridColumn;
				if (col.visible) {
					columns.push("col[]=" +col.dataField);
				}
			} 
			
			flash.external.ExternalInterface.call("window.open", "http://127.0.0.1:8000/report/member?method=pdf&" + columns.join("&"));
		}
	}
}

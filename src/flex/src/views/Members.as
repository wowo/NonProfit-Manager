package views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import models.Member;
	
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.containers.TitleWindow;
	import mx.controls.Button;
	import mx.controls.CheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;


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
		
		/**
		 * Customize view - displays popup where user can select columns to dispay @see  generateReport
		 * @param event
		 * 
		 */
		public static function customizeView(event:MouseEvent):void
		{
			Application.application.window = new TitleWindow();
			Application.application.window.title = "Dostosuj widok";
			Application.application.window.showCloseButton = true;
			Application.application.window.addEventListener(CloseEvent.CLOSE, Application.application.removeMe);
			
			var form:Form = new Form();
			for (var i in Application.application.grid.columns) {
				var item:FormItem = new FormItem();
				item.label = DataGridColumn(Application.application.grid.columns[i]).headerText;
				var checkbox:CheckBox = new CheckBox();
				checkbox.selected = DataGridColumn(Application.application.grid.columns[i]).visible;
				checkbox.name = DataGridColumn(Application.application.grid.columns[i]).dataField;
				checkbox.addEventListener(Event.CHANGE, toggleColumn);
				item.addChild(checkbox);
				form.addChild(item)
			}
			Application.application.window.addChild(form);
			
			PopUpManager.addPopUp(Application.application.window, Application.application.canvas,true);
			PopUpManager.centerPopUp(Application.application.window);		
		}
		
		/**
		 * Toggles column visibility  
		 * @param event
		 * 
		 */
		public static function toggleColumn(event:Event)
		{
			for (var i in Application.application.grid.columns) {
				if (DataGridColumn(Application.application.grid.columns[i]).dataField == CheckBox(event.currentTarget).name) {
					DataGridColumn(Application.application.grid.columns[i]).visible = CheckBox(event.currentTarget).selected;		
					break;
				}
			}
		}
	}
}

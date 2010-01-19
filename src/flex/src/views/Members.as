package views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import models.Member;
	
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.containers.TitleWindow;
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
		public static function addMember(event:MouseEvent):void
		{
			var newMember:Member = new Member();
			newMember.id = 0;
			newMember.name = Application.application.memberForm.nameInput.text;
			newMember.surname = Application.application.memberForm.surnameInput.text;
			newMember.fatherName = Application.application.memberForm.fatherNameInput.text;
			newMember.membershipType = Application.application.memberForm.membershipTypeInput.value;
			
			newMember.pesel = Application.application.memberForm.peselInput.text;
			newMember.identityCardNumber = Application.application.memberForm.identityCardNumberInput.text;
			
			newMember.birthDate = Application.application.memberForm.birthDateInput.selectedDate;
			newMember.accessionDate = Application.application.memberForm.accessionDateInput.selectedDate;
			newMember.dismissDate = Application.application.memberForm.dismissDateInput.selectedDate;
			
			newMember.address = Application.application.memberForm.addressInput.text;
			newMember.occupation = Application.application.memberForm.occupationInput.text;
			newMember.workplace = Application.application.memberForm.workplaceInput.text;
			
			newMember.phone = Application.application.memberForm.phoneInput.text;
			newMember.email = Application.application.memberForm.emailInput.text;
			newMember.ggNumber = Application.application.memberForm.ggNumberInput.text;
			newMember.comments = Application.application.memberForm.commentsInput.text;
			
			Application.application.membersRO.saveFromFlex(newMember);
			//Application.application.grid.dataProvider.AddItem(returnedMember);
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
			
			flash.external.ExternalInterface.call("window.open", Application.application.getEndpointUrl() + "/report/member?method=pdf&" + columns.join("&"));
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

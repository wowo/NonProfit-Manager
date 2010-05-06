package controllers
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import models.Member;
	
	import mx.collections.SortField;
	import mx.containers.Form;
	import mx.containers.FormItem;
	import mx.containers.TitleWindow;
	import mx.controls.Alert;
	import mx.controls.CheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.Application;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;
	import mx.managers.PopUpManager;
	import mx.rpc.events.ResultEvent;
	import mx.events.ListEvent;
	import mx.events.DataGridEvent;
	import mx.controls.TextInput;
	
	import views.components.MemberForm;
	
	public class MembersController extends Controller
	{
		public function MembersController(app:Application)
		{
			super(app);
		}
		
		/**
		 * Shows member form on new modal window.
		 *  
		 * @param event
		 */
		public function showMemberForm(event:MouseEvent):void
		{
			this.app.window = new TitleWindow();
			this.app.window.title = "Dodaj członka";
			this.app.window.showCloseButton = true;
			this.app.window.addEventListener(CloseEvent.CLOSE, function (event:CloseEvent):void {
				PopUpManager.removePopUp(Application.application.window);
			});
			
			this.app.memberForm = new MemberForm();
			this.app.window.addChild(this.app.memberForm);
			
			PopUpManager.addPopUp(this.app.window, this.app as Sprite, true);
			PopUpManager.centerPopUp(this.app.window);
		}
		
		/**
		 * @param event
		 */
		public function addMember(event:MouseEvent):void
		{
			var newMember:Member = new Member();
			newMember._id = '';
			newMember.name = this.app.memberForm.nameInput.text;
			newMember.surname = this.app.memberForm.surnameInput.text;
			newMember.fatherName = this.app.memberForm.fatherNameInput.text;
			newMember.membershipType = this.app.memberForm.membershipTypeInput.value;
			newMember.functions = this.app.memberForm.functionsInput.text;
			
			newMember.pesel = this.app.memberForm.peselInput.text;
			newMember.identityCardNumber = this.app.memberForm.identityCardNumberInput.text;
			
			newMember.birthDate = this.app.memberForm.birthDateInput.selectedDate;
			newMember.accessionDate = this.app.memberForm.accessionDateInput.selectedDate;
			newMember.dismissDate = this.app.memberForm.dismissDateInput.selectedDate;
			
			newMember.address = this.app.memberForm.addressInput.text;
			newMember.occupation = this.app.memberForm.occupationInput.text;
			newMember.workplace = this.app.memberForm.workplaceInput.text;
			
			newMember.phone = this.app.memberForm.phoneInput.text;
			newMember.email = this.app.memberForm.emailInput.text;
			newMember.ggNumber = this.app.memberForm.ggNumberInput.text;
			newMember.comments = this.app.memberForm.commentsInput.text;
			
			this.app.memberRO.save(newMember);
			//this.app.memberGrid.dataProvider.AddItem(returnedMember);
		}
		
		/**
		 * Displays confirmation box with members to remove listed.
		 *  
		 * @param event
		 */
		public function removeConfirm(event:MouseEvent):void
		{
			var members:String = "";
			for (var index:Object in this.app.memberGrid.selectedItems) {
				members += "\n\t" + Member(this.app.memberGrid.selectedItems[index]).toString();
			} 
			Alert.show(
				"Czy napewno usunąć następujących członków?" + members, 
				"Osrzeżenie", 
				mx.controls.Alert.OK | mx.controls.Alert.CANCEL, 
				this.app as Sprite, 
				this.remove
			);
		}
		
		/**
		 * Removes member.
		 * It calls memberRO::remove
		 *  
		 * @param event
		 */
		private function remove(event:CloseEvent):void
		{
			if(event.detail == mx.controls.Alert.OK) {
				for (var index:Object in this.app.memberGrid.selectedItems) {
					this.app.memberRO.remove(this.app.memberGrid.selectedItems[index] as Member);
				}
			}
		}
		
		/**
		 * Generates PDF report in new browser window (probably download it)
		 * @param event
		 */
		public function generateReport(event:MouseEvent):void
		{
			var columns:Array = new Array();
			var primaryKeys:Array = new Array();
			var sortCol:String = '';
			var sortDir:String = 'ASC';
			
			for (var i:Object in this.app.memberGrid.columns) {
				var col:DataGridColumn = this.app.memberGrid.columns[i] as DataGridColumn;
				if (col.visible && col.dataField != null) {
					columns.push("col[]=" + col.dataField);
				}
			}
			
			for (i in this.app.memberGrid.dataProvider) {
				var member:Member = this.app.memberGrid.dataProvider[i] as Member;
				if (member.selected) {
					primaryKeys.push("pk[]=" + member._id);
				}
				
			}
			
			if (this.app.memberGrid.dataProvider.sort) {
				var sort:SortField = this.app.memberGrid.dataProvider.sort.fields[0];
				sortCol = sort.name;
				sortDir = sort.descending ? 'DESC' : 'ASC';
			}
			flash.external.ExternalInterface.call(
				"window.open", 
				this.app.getEndpointUrl() + "/report/member?" + columns.join("&") + '&' + primaryKeys.join("&") + '&sortCol=' + sortCol + '&sortDir=' + sortDir
			);
		}
		
		/**
		 * Customize view - displays popup where user can select columns to dispay @see  generateReport
		 * @param event
		 */
		public function customizeView(event:MouseEvent):void
		{
			this.app.window = new TitleWindow();
			this.app.window.title = "Dostosuj widok";
			this.app.window.showCloseButton = true;
			this.app.window.addEventListener(CloseEvent.CLOSE, this.app.removeMe);
			
			var form:Form = new Form();
			for (var i:Object in this.app.memberGrid.columns) {
				if (DataGridColumn(this.app.memberGrid.columns[i]).dataField) {
					var item:FormItem = new FormItem();
					item.label = DataGridColumn(this.app.memberGrid.columns[i]).headerText;
					var checkbox:CheckBox = new CheckBox();
					checkbox.selected = DataGridColumn(this.app.memberGrid.columns[i]).visible;
					checkbox.name = DataGridColumn(this.app.memberGrid.columns[i]).dataField;
					checkbox.addEventListener(Event.CHANGE, toggleColumn);
					item.addChild(checkbox);
					form.addChild(item);
				}
			}
			this.app.window.addChild(form);
			
			PopUpManager.addPopUp(this.app.window, this.app.canvas,true);
			PopUpManager.centerPopUp(this.app.window);		
		}
		
		/**
		 * Toggles column visibility  
		 * @param event
		 * 
		 */
		public function toggleColumn(event:Event):void
		{
			for (var i:Object in this.app.memberGrid.columns) {
				if (DataGridColumn(this.app.memberGrid.columns[i]).dataField == CheckBox(event.currentTarget).name) {
					DataGridColumn(this.app.memberGrid.columns[i]).visible = CheckBox(event.currentTarget).selected;		
					break;
				}
			}
		}
		
		/**
		 * Members Grid initialize.
		 * Calls getAll on memberRO to fill them into the grid.
		 *   
		 * @param event
		 */
		public function gridInitialize(event:FlexEvent):void
		{
			this.app.memberRO.getAll();
		}
		
		/**
		 * Method fired when item on member grid is double clicked.
		 * It sets this item as edited, and sets grid editable.
		 *  
		 * @param event
		 */		
		public function gridItemDoubleClickHandler(event:ListEvent):void
		{
			if (event.isDefaultPrevented()) {
				return;
			} else {
				this.app.memberGrid.editedItemPosition = {columnIndex: event.columnIndex + 1, rowIndex: event.rowIndex};
				this.app.memberGrid.editable = true;
			}
		}
		
		public function gridItemEditEndHandler(event:DataGridEvent):void
		{
			var oldValue:String = Member(this.app.memberGrid.selectedItem)[event.dataField];
			var newValue:String = TextInput(event.currentTarget.itemEditorInstance).text;
			if (newValue != oldValue) {
				var memberToSave:Member =this.app.memberGrid.selectedItem as Member;
				memberToSave[event.dataField] = newValue;
				this.app.memberRO.save(memberToSave);
			}
			this.app.memberGrid.editable = false;
		}
		
		/**
		 * Handles results from memberRO getAll method call
		 * It sets result to memberGrid and counts rows to show its number in textbox
		 * 
		 * @param event
		 */
		public function getAllResultHandler(event:ResultEvent):void
		{
			this.app.memberGrid.dataProvider = event.result;
			this.app.rowsCount = 0;
			for (var m:Object in this.app.memberGrid.dataProvider) {
				this.app.rowsCount++;
			}
		}
		
		/**
		 * Method called after memberRO::save call.
		 * It refreshes grid and also removes modal window
		 *  
		 * @param event
		 */
		public function saveResultHandler(event:ResultEvent):void
		{
			this.app.memberRO.getAll();
			PopUpManager.removePopUp(this.app.window);
		}
		
		/**
		 * Method called after memberRO::remove call.
		 * It refreshes grid.
		 * 
		 * @param event
		 */
		public function removeResultHandler(event:ResultEvent):void
		{
			this.app.memberRO.getAll();
		}
	}
}
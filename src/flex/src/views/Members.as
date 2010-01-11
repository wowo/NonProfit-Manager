package views
{
	import components.MemberForm;
	
	import flash.events.MouseEvent;
	
	import models.Member;
	
	import mx.core.Application;

	public class Members
	{
		public function Members()
		{
		}
		
		public static function	saveMember(event:MouseEvent):void
		{
			var newMember:Member = new Member();
			newMember.id = 0;
			
			newMember.name = Application.application.memberFormInstance.nameInput.text;
			newMember.surname = Application.application.memberFormInstance.surnameInput.text;
			newMember.fatherName = Application.application.memberFormInstance.fatherNameInput.text;
			Application.application.membersRO.save(newMember);
		}
	}
}
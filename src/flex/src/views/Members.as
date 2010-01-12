package views
{
	import mx.core.Application;
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
			newMember.name = Application.application.memberForm.memberNameInput.text;
			newMember.surname = Application.application.memberForm.memberSurnameInput.text;
			newMember.fatherName = Application.application.memberForm.memberFatherNameInput.text;
			Application.application.membersRO.save(newMember);
		}
	}
}

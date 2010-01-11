package views
{
	import flash.events.MouseEvent;
	
	import models.Member;

	public class Members
	{
		public function Members()
		{
		}
		
		public static function	saveMember(event:MouseEvent):void
		{
			var newMember:Member = new Member();
			newMember.id = 0;
			newMember.name = memberFormInstance.nameInput.text;
			newMember.surname = memberFormInstance.surnameInput.text;
			newMember.fatherName = memberFormInstance.fatherNameInput.text;
			membersRO.save(newMember);
		}
	}
}
package views
{
	import components.MemberForm;
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
			newMember.name = memberNameInput.text;
			newMember.surname = memberSurnameInput.text;
			newMember.fatherName = memberFatherNameInput.text;
			membersRO.save(newMember);
		}
	}
}
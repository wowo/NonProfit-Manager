package models
{
	[Bindable]
	[RemoteClass(alias="Member")]	
	public class Member
	{
		public var _id:String;
		public var name:String;
		public var surname:String;
		public var fatherName:String;
		public var birthDate:Date;
		public var birthPlace:String;
		public var occupation:String;
		public var workplace:String;
		public var accessionDate:Date;
		public var dismissDate:Date;
		public var functions:String;
		public var address:String;
		public var identityCardNumber:String;
		public var pesel:String;
		public var email:String;
		public var phone:String;
		public var ggNumber:String;
		public var membershipType:String;
		public var comments:String;
		public var sections:String;
		public var createdAt:Date;
		public var updatedAt:Date;
		public var selected:Boolean;

		public function Member()
		{
			//TODO: implement function
		}
		
		public function toString():String
		{
			return "#" + this._id + " " + this.name + " " + this.surname;
		}

	}
}
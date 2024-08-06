switch(room)
{
	case room_logo:
	case room_menu:
	case room_connecting:
	case room_results:
		jUse = false;
		bUse = false;
		break;
	
	case room_lobby:
		jUse = false;
		bUse = true;
		break;
		
	default:
		jUse = true;	
		bUse = true;
}
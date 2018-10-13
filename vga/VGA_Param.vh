//	Horizontal Parameter	( Pixel )
parameter	H_SYNC_CYC	=	18;
parameter	H_SYNC_BACK	=	20;
parameter	H_SYNC_ACT	=	800;	
parameter	H_SYNC_FRONT=	218;
parameter	H_SYNC_TOTAL=	1056;

//	Vertical Parameter		( Line )
parameter	V_SYNC_CYC	=	2;
parameter	V_SYNC_BACK	=  20;
parameter	V_SYNC_ACT	=	480;	
parameter	V_SYNC_FRONT=	17;
parameter	V_SYNC_TOTAL=	525;
//	Start Offset
parameter	X_START		=	H_SYNC_CYC+H_SYNC_BACK;
parameter	Y_START		=	V_SYNC_CYC+V_SYNC_BACK;

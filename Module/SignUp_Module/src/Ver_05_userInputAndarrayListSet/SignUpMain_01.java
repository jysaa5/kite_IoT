package Ver_05_userInputAndarrayListSet;


//SignUpMain_01: 실행 클래스
public class SignUpMain_01 {

	public static void main(String args[]) {
		
	SignUpFunction_01 function = SignUpFunction_01.getInstance();

	while (true) {
		System.out.println("==========================");
		System.out.println("메뉴를 입력해주세요.");
		System.out.println(Menu.INSERT_UNIV+". 대학친구입력");
		System.out.println(Menu.INSERT_COM+". 회사친구입력");
		System.out.println(Menu.SEARCH+". 친구 검색");
		System.out.println(Menu.DELETE+". 친구 삭제");
		System.out.println(Menu.LIST+". 친구 전체 리스트");
		System.out.println(Menu.EXIT+". 프로그램 종료");
		System.out.println("==========================");

		String str = function.sc.nextLine();
		
		//입력받은 문자열이 숫자가 인지 아닌지 검사하는 구간
		char temp;
		boolean output = true;
		
		for(int i=0; i<str.length();i++) {
			temp = str.charAt(i);
			
			if(Character.isDigit(temp)==false) {
				output = false;
			}
		}
		
		if(str == null || str.equals("") || output == false) {

			System.out.println("번호를 입력해주세요.");
	
		}else {
			int select = Integer.parseInt(str);
			
		switch (select) {
		case Menu.INSERT_UNIV:
			function.insertInfo(select);
			break;
		case Menu.INSERT_COM:
			function.insertInfo(select);
			break;
		case Menu.SEARCH:
			function.searchInfo();
			break;
		case Menu.DELETE:
			function.deleteInfo();
			break;
		case Menu.LIST:
			function.showAll();
			break;
		case Menu.EXIT:
			System.out.println("프로그램을 종료합니다.");
			return;
		
		default: System.out.println("올바른 메뉴 번호를 입력해주세요.");
			continue;
		}
	}
	}
}	
	
}//SignUpMain_01 클래스 끝

package imgInfo;

import java.util.Calendar;

public class DayOfWeek {
	public String[] weekCalendar(String yyyymmdd) throws Exception{
		  
		  Calendar cal = Calendar.getInstance();
		  int toYear = 0;
		  int toMonth = 0;
		  int toDay = 0;
		  if(yyyymmdd == null || yyyymmdd.equals("")){   //파라메타값이 없을경우 오늘날짜
		   toYear = cal.get(cal.YEAR); 
		   toMonth = cal.get(cal.MONTH)+1;
		   toDay = cal.get(cal.DAY_OF_MONTH);
		   
		   int yoil = cal.get(cal.DAY_OF_WEEK); //요일나오게하기(숫자로)

		   if(yoil != 1){   //해당요일이 일요일이 아닌경우
		    yoil = yoil-2;
		   }else{           //해당요일이 일요일인경우
		    yoil = 7;
		   }
		   cal.set(toYear, toMonth-1, toDay-yoil);  //해당주월요일로 세팅
		  }else{
		   int yy =Integer.parseInt(yyyymmdd.substring(0, 4));
		   int mm =Integer.parseInt(yyyymmdd.substring(4, 6))-1;
		   int dd =Integer.parseInt(yyyymmdd.substring(6, 8));
		   cal.set(yy, mm,dd);
		  }
		  String[] arrYMD = new String[7];
		  
		  int inYear = cal.get(cal.YEAR); 
		  int inMonth = cal.get(cal.MONTH);
		  int inDay = cal.get(cal.DAY_OF_MONTH);
		  int yoil = cal.get(cal.DAY_OF_WEEK); //요일나오게하기(숫자로)
		  if(yoil != 1){   //해당요일이 일요일이 아닌경우
		      yoil = yoil-2;
		   }else{           //해당요일이 일요일인경우
		      yoil = 7;
		   }
		  inDay = inDay-yoil;
		  for(int i = 0; i < 7;i++){
		   cal.set(inYear, inMonth, inDay+i);  //
		   String y = Integer.toString(cal.get(cal.YEAR)); 
		   String m = Integer.toString(cal.get(cal.MONTH)+1);
		   String d = Integer.toString(cal.get(cal.DAY_OF_MONTH));
		   if(m.length() == 1) m = "0" + m;
		   if(d.length() == 1) d = "0" + d;
		   
		   arrYMD[i] = y+ "-" + m + "-" +d;
		   
		  }
		  
		  return arrYMD;
		 }

		
}

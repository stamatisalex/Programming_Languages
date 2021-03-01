import java.util.*;

public class  Tuple  {
  private String ans;
  private  String remain;
  private  String s; //first element of second String
  private  String bottom;
  private  boolean flag;
  private  boolean flag2;
  private  String letters;
	private  Tuple previous;

  public  Tuple(String ans, String remain , String s, String bottom, boolean flag , boolean flag2,String letters,Tuple previous) {
       this.ans = ans;
       this.remain=remain;
       this.s=s;
       this.bottom=bottom;
       this.flag=flag;
       this.flag2=flag2;
       this.letters=letters;
       this.previous=previous;
   }

  public static String complement(String rna){
      StringBuilder builder = new StringBuilder();
      for(int i=0;i<rna.length();i++){
          char c = rna.charAt(i);
          if(rna.charAt(i) == 'U'){
              builder.append('A');
          }
          if(rna.charAt(i) == 'A'){
              builder.append('U');
          }
          if(rna.charAt(i) == 'C'){
              builder.append('G');
          }
          if(rna.charAt(i) == 'G'){
              builder.append('C');
          }
      }
      return builder.toString();
  }

  public String getAns() {
		return ans;
	}

  public String getRemain() {
    return remain;
  }

  public Tuple getPrevious() {
    return previous;
  }

	public Collection<Tuple> next() {
    //Same logic with Python.Keep only the first and the last char of the Second string
    //First case complement
		Collection<Tuple> Q = new ArrayDeque<>();
    if(!(flag&&flag2)){
      if(!flag){
        flag=true;
          String second1=s;
          String reversed=complement(remain); //complement
        Q.add(new  Tuple("c",reversed,second1,bottom,flag,flag2,letters,this));

      }
    }
    //Push
    int length1=remain.length();
    String remain1=remain.substring(0,length1 - 1);
    String  check=remain.substring(length1-1);

    if(check.equals(s) || (letters.indexOf(check)==-1)){
        String haslet=letters;
        //System.out.println("yes it is ");
        if(haslet.indexOf(check)==-1)
          haslet=haslet+check;
    Tuple Tu = new  Tuple("p",remain1,check,bottom,false,false,haslet,this);
//System.out.println(Tu);
    Q.add(Tu);
}
//Reverse
    if(!(flag&&flag2)){
      if(!flag2){
        flag2=true;
        String remain2=remain;
        Q.add(new  Tuple("r",remain2,bottom,s,flag,true,letters,this));
      }
    }
		return Q;
	}

	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;
		 Tuple other = ( Tuple) o;
		return (ans.equals(other.ans)) && (remain.equals(other.remain)) && (s.equals(other.s)) && (bottom.equals(other.bottom)) && (flag == other.flag)&&(flag2 == other.flag2) && (letters.equals(other.letters)) ;
	}

	public int hashCode() {
		return Objects.hash(ans,remain,s,bottom,flag,flag2,letters);
	}
}

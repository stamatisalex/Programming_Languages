import java.io.*;
import java.util.*;

public class Vaccine{

  public static Tuple BFSvac(String s1){
        String top=s1.substring(s1.length()-1);
        s1=s1.substring(0,s1.length() - 1);
        String letters=""; //letters/chars that the second stack contains
        letters=letters+top;
        //Για πιο αναλυτικα στη διαδικασια που εχω ακολουθησει βλεπε στο υποβληθεν αρχειο της Python. Ουσισαστικα κανω τις 3 κινησεις με τη σειρα c-p-r απορριπτοντας συνεχομενες επαναληψεις
        //cr,rc,rr,cc και παντα κρατω το πρωτο και το τελευταιο στοιχειο του δευτερου string για μεγαλυτερη ταχυτητα 
    Set<Tuple> seen = new HashSet<>();
    Queue<Tuple> remaining = new ArrayDeque<>();
    Tuple Tu = new  Tuple("p",s1,top,top,false,false,letters,null);
    remaining.add(Tu);
    seen.add(Tu);
    while (!remaining.isEmpty()) {
      Tuple s = remaining.remove();
      if (s.getRemain().isEmpty()) return s;
      for (Tuple n : s.next())
        if (!seen.contains(n)){
          remaining.add(n);
          seen.add(n);
        }
    }
    return null;

  }

  public static void main(String args[])
  {
  //long beforeUsedMem=Runtime.getRuntime().totalMemory()-Runtime.getRuntime().freeMemory();
    try {
      //long beforeUsedMem=Runtime.getRuntime().totalMemory()-Runtime.getRuntime().freeMemory();
      BufferedReader reader = new BufferedReader(new FileReader(args[0]));
      String st = reader.readLine();
      for(int a=0;a<Integer.parseInt(st);a++){
        String line = reader.readLine();
        printreverse(BFSvac(line));
        System.out.println();
      }
      reader.close();
     //long afterUsedMem=Runtime.getRuntime().totalMemory()-Runtime.getRuntime().freeMemory();
    //  long actualMemUsed=afterUsedMem-beforeUsedMem;
    //  System.out.println(actualMemUsed);
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  private static void printreverse(Tuple s) {
    if (s.getPrevious() != null) {
      printreverse(s.getPrevious());
    }
    System.out.print(s.getAns());
  }
}

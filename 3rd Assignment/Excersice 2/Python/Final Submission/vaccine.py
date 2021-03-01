from collections import deque

def main(f):
    N=f.readline()
    for i in range(int(N)):
        string=f.readline()
        stack=string[:-1]
        print(BFS(stack))
    return ;

#Υλοποιηση BFS με την βοηθεια της συναρτησης checkforp . Για καθε πιθανη κατασταση εισαγουμε
#στην Q τις επομενες δυνατες  καταστασεις με την αλφαβητικη σειρα (c,p,r) και ελεγχουμε για καθε κατασταση  αν
#αυτη ειναι αποδεκτη με την βοηθεια της checkforp. Προφανως ο ελεγχος γινεται μονο στη περιπτωση που
# η τελευταια κίνηση ειναι p .Εχουμε υλοποιησει τον ελεγχο αυτό με δύο τρόπους(checkforp/checkAll).Βέβαια
#η checkforp ειναι πιο γρηγορη γιατι ελεχει τα δυο κορυφαια στοιχεια του δευτερου string (ή σε περιπτωση
# αποτυχιας αν εχει επισκεφτει ο χαρακατηρας που εισαγεται. Για πιο γρηγορη λυση εισαγουμε μονο το πρωτο και
# το τελευταιο στοιχειο της δευτερης λυσης.Ιδια λογικη εχω ακολουθησει και στα προγραμματα της Java και Prolog
#Η checkAll εχει πολυπλοκοτητα αντιθετα O(N) για αυτό και δεν την χρησιμοποιούμε
def BFS(s1):
    Q=deque()
    top=s1[-1]
    s1=s1[:-1]
    letters=""
    letters=letters+top
    Q.append(("p",s1,top,top,0,0,letters))
    seen=set([])
    trans = str.maketrans('AUGC', 'UACG')
    while Q:
        ans,remain,s,bottom,flag,flag2,letter = Q.popleft()
        h=(remain,s,bottom,flag,flag2,letter)
        if h not in seen:
            seen.add(h)
            #print("left: {}, right: {}, bottom:{} ,ans: {}".format("".join(remain), "".join(s),"".join(bottom),"".join(ans)))
            if(remain==""):
                #if ((l==length)):
                    return ans
            else:
                if(flag2*flag==0):
                    second1=s
                    if(flag==0):
                        flag=1
                        reversed=remain.translate(trans)
                        Q.append((ans+"c",reversed,second1,bottom,flag,flag2,letter))
                remain1=remain[:-1]
                check=remain[-1]
                checkforp(Q,ans,"p",remain1,s,bottom,0,0,letter,check)
                if(flag2*flag==0):
                    if(flag2==0):
                        flag2=1
                        Q.append((ans+"r",remain,bottom,second1,flag,1,letter))


def checkforp(Q, changes, char,remain, s,bottom,flag,flag2,letter,check):
    if(check==s or (check not in letter)):
        if(check not in letter):
            letter=letter+check
        copy=changes+char
        Q.append((copy,remain,check,bottom,flag,flag2,letter))




# A stack based function to reverse a string
def reverse(string):
    return string[::-1]
    #β τρόπος
    #string = "".join(reversed(string))
    #return string

def List_to_String(l):
    str=""
    return str.join(l)

def split(word):
    return [char for char in word]
#string complement
def complement(seq):
    complement = {'A': 'U', 'C': 'G', 'G': 'C', 'U': 'A'}
    reverse_complement = "".join([complement[base] for base in (seq)])
    return reverse_complement
# β τρόπος αντι για checkforp
def checkAll(str):
  seen_letters = set() # set of seen letters so far
  last_letter = None
  for c in str:
    if last_letter == c:  # if it is the same letter as before continue
      continue
    if (last_letter != c and c in seen_letters):  # seen before and a new cluster
      return False
    seen_letters.add(c) # new unsee cluster
    last_letter = c
  return True


if __name__ == "__main__":
        import sys
        if len(sys.argv) > 1:
                with open(sys.argv[1], "rt") as f:
                        main(f)
        else:
                main(sys.stdin)

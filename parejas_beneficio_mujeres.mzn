include "globals.mzn";

enum Women = {Ana, Marta, Patricia};
enum Men = {Carlos, Marco, Juan};

array[Women, Men] of int: wrank = [|1, 2, 3,|3, 2, 1,|3, 1, 2|];
array[Men, Women] of int: mrank = [|2, 1, 3,|1, 2, 3,|1, 3, 2|];
array[Men] of var Women: wife;
array[Women] of var Men: husband;

var int: Obj_women = sum(w in Women, m in Men where wrank[w, m]=1)(husband[w]=m);
var 0..3: obj_men;
var 0..3: obj_women; obj_women = Obj_women;

constraint forall(m in Men)(husband[wife[m]] = m) /\ forall(w in Women)(wife[husband[w]] = w);  
constraint forall(m in Men, w in Women)(mrank[m,w] < mrank[m, wife[m]] -> wrank[w,husband[w]] < wrank[w,m]);
solve maximize obj_women;

output["wife: ", show(wife), "\n" , "husband: ", show(husband), "\n" , "obj_men: ", show(obj_men), "\n" , "obj_women: ", show(obj_women)]
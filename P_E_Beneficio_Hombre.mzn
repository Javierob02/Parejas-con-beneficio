include "globals.mzn";
enum Women = {Ana, Marta, Patricia};
enum Men = {Carlos, Marco, Juan};

array[Women, Men] of int: wrank = [|1, 2, 3,|3, 2, 1,|3, 1, 2|];
array[Men, Women] of int: mrank = [|2, 1, 3,|1, 2, 3,|1, 3, 2|];
array[Men] of var Women: wife;
array[Women] of var Men: husband;

var int: Obj_men = sum(m in Men, w in Women where mrank[m, w]=1)(wife[m]=w);
var 0..3: obj_men; obj_men = Obj_men;
var 0..3: obj_women;

constraint forall(m in Men)(husband[wife[m]] = m) /\ forall(w in Women)(wife[husband[w]] = w);  
constraint forall(m in Men, w in Women)(mrank[m,w] < mrank[m, wife[m]] -> wrank[w,husband[w]] < wrank[w,m]);
solve maximize obj_men;


%inverse wife, husband  5iwlt9
%estabilidad -> husband debe ser 1 de wife Y viceversa
%mrank[yo, caludia] < mrank[yo, wife[yo]] --> ...
%wrank[claudia, husband[claudia]] < wrank[claudia, yo]
%constraint forall(m in Man, w in Women)
-- More comments are possible if requested
package Connect with SPARK_Mode
   is

   subtype Index is Positive range 1 .. 80;
   type Vector is array (1..2) of Integer;
   type Walk is array (Index) of Vector;

   type Move is (Up, Down, Left, Right);
   type Steps is array (Index'First+1 .. Index'Last) of Move;


   function Get_Snake (A: Steps) return Walk
   with Post => ((for all I in Index'First+1 .. Index'Last => ((Get_Snake'Result(I)(1)-Get_Snake'Result(I-1)(1))*(Get_Snake'Result(I)(1)-Get_Snake'Result(I-1)(1))+
                                                               (Get_Snake'Result(I)(2)-Get_Snake'Result(I-1)(2))*(Get_Snake'Result(I)(2)-Get_Snake'Result(I-1)(2))=1)) and
                   (for all J in Index'First+1 .. Index'Last => Get_Snake'Result(J)(1)<=J and Get_Snake'Result(J)(1)>=-J and Get_Snake'Result(J)(2)<=J and Get_Snake'Result(J)(2)>=-J)
                 and (Get_Snake'Result(Index'First)(1)=0 and Get_Snake'Result(Index'First)(2)=0));
   -- Post Condition tries to prove that the random walk is connected, some useful fact 1.0 about the length (coordinate of the node can't exceed the length of the walk up to that node for any axis)
   -- and random walk starts from the origin (0,0) point

   function Get_Distance (W: Walk) return Integer
     with Pre => ((for all I in Index'First+1 .. Index'Last => (W(I)(1)>=-Index'Last and W(I)(1)<=Index'Last and W(I)(2)>=-Index'Last and W(I)(2)<=Index'Last)) and then
                  (W(Index'First)(1)=0 and W(Index'First)(2)=0)
                  and then ((for all I in Index'First+1 .. Index'Last => (((W(I)(1)-W(I-1)(1))>=-1 and (W(I)(1)-W(I-1)(1))<=1) and ((W(I)(2)-W(I-1)(2))>=-1 and (W(I)(2)-W(I-1)(2))<=1))))),
   -- Precondition requires relationship between length and coordinates of the walk mentioned above (Fact 1.0), requres starting from the origin and single step in any dimension be not greater
   -- in value than one
     Post => Get_Distance'Result<2*(Index'Last+1)*(Index'Last+1);



end Connect;
